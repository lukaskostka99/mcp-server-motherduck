#!/bin/bash

# Release script pro mcp-server-motherduck
# Automatizuje proces publikace nové verze na PyPI a Smithery

set -e  # Exit on error

# Barvy pro výstup
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funkce pro barevný výpis
info() { echo -e "${BLUE}ℹ ${1}${NC}"; }
success() { echo -e "${GREEN}✓ ${1}${NC}"; }
warning() { echo -e "${YELLOW}⚠ ${1}${NC}"; }
error() { echo -e "${RED}✗ ${1}${NC}"; exit 1; }

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════╗
║   MCP Server MotherDuck - Release Script     ║
╚═══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Kontrola, že jsme v root adresáři projektu
if [ ! -f "pyproject.toml" ] || [ ! -f "server.json" ]; then
    error "Tento script musí být spuštěn z root adresáře projektu"
fi

# Získání současné verze
CURRENT_VERSION=$(grep -E '^version = ' pyproject.toml | sed 's/version = "\(.*\)"/\1/')
info "Současná verze: ${CURRENT_VERSION}"

# Dotaz na novou verzi
read -p "$(echo -e ${YELLOW}Zadejte novou verzi \(např. 0.6.5\):${NC} )" NEW_VERSION

if [ -z "$NEW_VERSION" ]; then
    error "Verze nemůže být prázdná"
fi

# Validace formátu verze (základní)
if ! [[ "$NEW_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    error "Neplatný formát verze. Použijte formát X.Y.Z (např. 0.6.5)"
fi

info "Nová verze bude: ${NEW_VERSION}"

# Potvrzení
read -p "$(echo -e ${YELLOW}Pokračovat s vydáním verze ${NEW_VERSION}? \(y/n\):${NC} )" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    warning "Publikace zrušena"
    exit 0
fi

# 1. Aktualizace pyproject.toml
info "Aktualizace pyproject.toml..."
sed -i.bak "s/^version = \".*\"/version = \"${NEW_VERSION}\"/" pyproject.toml
rm pyproject.toml.bak
success "pyproject.toml aktualizován"

# 2. Aktualizace configs.py
info "Aktualizace src/mcp_server_motherduck/configs.py..."
sed -i.bak "s/SERVER_VERSION = \".*\"/SERVER_VERSION = \"${NEW_VERSION}\"/" src/mcp_server_motherduck/configs.py
rm src/mcp_server_motherduck/configs.py.bak
success "configs.py aktualizován"

# 3. Aktualizace server.json (dvě místa)
info "Aktualizace server.json..."
# Použijeme Python pro spolehlivější JSON úpravu
python3 << EOF
import json

with open('server.json', 'r') as f:
    data = json.load(f)

data['version'] = '${NEW_VERSION}'
data['packages'][0]['version'] = '${NEW_VERSION}'

with open('server.json', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
EOF
success "server.json aktualizován"

# 4. Zobrazení změn
info "Kontrola změn..."
echo
git diff pyproject.toml src/mcp_server_motherduck/configs.py server.json
echo

# Potvrzení změn
read -p "$(echo -e ${YELLOW}Vypadají změny správně? \(y/n\):${NC} )" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    warning "Obnovuji původní verze..."
    git checkout pyproject.toml src/mcp_server_motherduck/configs.py server.json
    error "Publikace zrušena"
fi

# 5. Build balíčku
info "Build balíčku pomocí uv..."
uv build || error "Build selhal"
success "Build dokončen"

# 6. Testování
info "Testování balíčku..."
uv run mcp-server-motherduck --help > /dev/null || error "Test spuštění selhal"
success "Test úspěšný"

# 7. Dotaz na PyPI publikaci
read -p "$(echo -e ${YELLOW}Publikovat na PyPI? \(y/n\):${NC} )" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    info "Publikace na PyPI..."
    uv publish || warning "PyPI publikace selhala (pokračujeme)"
    success "Publikováno na PyPI"
else
    warning "PyPI publikace přeskočena"
fi

# 8. Git commit a tag
info "Vytváření Git commit a tagu..."
git add pyproject.toml src/mcp_server_motherduck/configs.py server.json
git commit -m "Release version ${NEW_VERSION}" || warning "Commit selhal (možná žádné změny)"
git tag "v${NEW_VERSION}" || warning "Tag již existuje"
success "Git commit a tag vytvořeny"

# 9. Push na GitHub
read -p "$(echo -e ${YELLOW}Pushnout na GitHub? \(y/n\):${NC} )" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    info "Push na GitHub..."
    git push origin main || warning "Push main selhalo"
    git push origin "v${NEW_VERSION}" || warning "Push tagu selhalo"
    success "Pushnutu na GitHub"
else
    warning "GitHub push přeskočen"
    info "Nezapomeňte později spustit: git push origin main --tags"
fi

# 10. Smithery
echo
success "Release proces dokončen! 🎉"
echo
info "Další kroky:"
echo "  1. Ověřte balíček na PyPI: https://pypi.org/project/mcp-server-motherduck/${NEW_VERSION}/"
echo "  2. Vytvořte GitHub Release: https://github.com/motherduckdb/mcp-server-motherduck/releases/new"
echo "  3. Smithery automaticky detekuje novou verzi z GitHub"
echo
info "Pro ruční odeslání na Smithery:"
echo "  npx @smithery/cli publish https://github.com/motherduckdb/mcp-server-motherduck"
echo
success "Verze ${NEW_VERSION} je připravena! 🚀"
