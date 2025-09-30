# Smithery Deployment Checklist

Použijte tento checklist před nasazením na Smithery.

## ✅ Před-publikační kontrola

### Konfigurace projektu
- [x] `pyproject.toml` obsahuje správné metadata
- [x] Verze je konzistentní napříč soubory
- [x] Dependencies jsou aktuální a správně specifikované
- [x] `project.scripts` obsahuje správný entry point

### smithery.yaml (VYŽADOVÁNO)
- [x] Soubor existuje v root adresáři
- [x] `mcp.name` odpovídá názvu serveru
- [x] `startCommand` je správně nakonfigurován
- [x] `configSchema` definuje všechny parametry
- [x] `build.type` je nastaven na `pypi`
- [x] `build.package` odpovídá PyPI package name
- [x] `examples` poskytují užitečné příklady konfigurace

### server.json
- [x] Soubor existuje v root adresáři
- [x] Schema je validní: `https://static.modelcontextprotocol.io/schemas/2025-07-09/server.schema.json`
- [x] `name` je ve správném formátu: `io.github.motherduckdb/mcp-server-motherduck`
- [x] `description` je jasný a výstižný
- [x] `status` je nastaven na `"active"`
- [x] `repository.url` odkazuje na správný GitHub repo
- [x] `version` odpovídá verzi v `pyproject.toml`
- [x] `packages[0].registry_type` je `"pypi"`
- [x] `packages[0].identifier` odpovídá PyPI package name
- [x] `package_arguments` jsou kompletní a správné
- [x] `environment_variables` jsou zdokumentované

### PyPI publikace
- [ ] Balíček je publikován na PyPI s aktuální verzí
- [ ] PyPI package name odpovídá `server.json`
- [ ] Package metadata na PyPI je kompletní
- [ ] README je správně zobrazen na PyPI

### GitHub repository
- [x] Repository je veřejný
- [x] README.md obsahuje kompletní dokumentaci
- [x] LICENSE soubor je přítomen
- [x] Příklady použití jsou v README
- [x] Instalační instrukce jsou jasné

### Testování
- [ ] Server lze nainstalovat pomocí `uvx mcp-server-motherduck`
- [ ] Server se správně spouští s `--help`
- [ ] Základní funkce (query) funguje
- [ ] Všechny transportní režimy (stdio, sse, stream) fungují
- [ ] Server funguje v Claude Desktop
- [ ] Server funguje v Cursor/VS Code

### Dokumentace
- [x] README obsahuje sekci "Getting Started"
- [x] Jsou příklady pro různé MCP klienty
- [x] Jsou příklady pro různé use cases
- [x] Troubleshooting sekce je přítomna
- [x] Command line parametry jsou zdokumentované

## 📦 Publikace na Smithery

### Metoda 1: Web Interface
1. [ ] Navštívit https://smithery.ai
2. [ ] Přihlásit se pomocí GitHub
3. [ ] Kliknout na "Submit Server"
4. [ ] Zadat GitHub repository URL
5. [ ] Ověřit automatickou validaci
6. [ ] Potvrdit a publikovat

### Metoda 2: CLI
```bash
# Instalace Smithery CLI
npm install -g @smithery/cli

# Přihlášení
smithery login

# Publikace
cd /Users/lukaskostka/motherduck-mcp/mcp-server-motherduck
smithery publish .
```

## 🧪 Post-publikační validace

### Smithery
- [ ] Server je viditelný na Smithery.ai
- [ ] Metadata jsou správně zobrazena
- [ ] Instalační instrukce fungují
- [ ] Badge funguje (pokud přidáno)

### Instalace přes Smithery CLI
```bash
# Test instalace
npx @smithery/cli install mcp-server-motherduck

# Test inspekce
npx @smithery/cli inspect mcp-server-motherduck
```

### Funkční testy
- [ ] Server lze spustit po instalaci přes Smithery
- [ ] Všechny parametry fungují
- [ ] Environment variables jsou respektovány
- [ ] Query tool funguje správně

## 🔄 Aktualizace verze

Při publikaci nové verze:

1. [ ] Aktualizovat `SERVER_VERSION` v `src/mcp_server_motherduck/configs.py`
2. [ ] Aktualizovat `version` v `pyproject.toml`
3. [ ] Aktualizovat `version` a `packages[0].version` v `server.json`
4. [ ] Build: `uv build`
5. [ ] Test lokálně: `uv run mcp-server-motherduck --help`
6. [ ] Publish na PyPI: `uv publish`
7. [ ] Commit a push: `git add . && git commit -m "Release vX.Y.Z"`
8. [ ] Tag: `git tag vX.Y.Z && git push origin main --tags`
9. [ ] Vytvořit GitHub Release
10. [ ] Smithery automaticky detekuje novou verzi

## 📊 Monitoring

Po publikaci:

- [ ] Sledovat download statistics na PyPI
- [ ] Sledovat GitHub stars a issues
- [ ] Sledovat Smithery analytics (pokud dostupné)
- [ ] Reagovat na user feedback

## 🆘 Troubleshooting

### Smithery nezobrazuje server
1. Zkontrolovat validitu `server.json`
2. Ověřit, že GitHub repo je public
3. Ověřit, že balíček existuje na PyPI s uvedenou verzí

### Instalace selhává
1. Zkontrolovat PyPI dostupnost
2. Ověřit dependencies
3. Testovat `uvx mcp-server-motherduck` přímo

### Verze se neaktualizuje
1. Ověřit novou verzi na PyPI
2. Zkontrolovat `server.json` verzi
3. Vytvořit GitHub release s tagem

## ✅ Checklist status

Aktuální stav: **PŘIPRAVEN K PUBLIKACI**

Co zbývá:
- [ ] Publikovat aktuální verzi na PyPI (pokud ještě není)
- [ ] Odeslat na Smithery
- [ ] Post-publikační validace

## Poznámky

- Server má vynikající dokumentaci v README
- `server.json` je kompletní a validní
- Projekt má dobrou strukturu a je maintainable
- Všechny běžné use cases jsou pokryté

Datum poslední aktualizace: 2025-09-30
