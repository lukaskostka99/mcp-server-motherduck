# Smithery QuickStart - mcp-server-motherduck

Rychlý průvodce pro nasazení na Smithery za 5 minut.

## 🚀 Rychlé nasazení

### Krok 1: Ověření konfigurace (30 sekund)

Ujistěte se, že všechny konfigurační soubory existují:

```bash
# Zkontrolovat, že smithery.yaml existuje (VYŽADOVÁNO)
ls -la smithery.yaml

# Zkontrolovat verze
grep version pyproject.toml
grep SERVER_VERSION src/mcp_server_motherduck/configs.py
grep '"version"' server.json
```

✅ **smithery.yaml** - již vytvořen  
✅ Všechny verze by měly ukazovat **0.6.4**

### Krok 2: Publikace na PyPI (2 minuty)

```bash
# Build balíčku
uv build

# Publikace (vyžaduje PyPI token)
uv publish

# Nebo s explicitním tokenem
uv publish --token pypi-YOUR_TOKEN_HERE
```

### Krok 3: Odeslání na Smithery (2 minuty)

#### Varianta A: Web Interface (jednodušší)

1. Otevřít https://smithery.ai
2. Kliknout "Submit Server" nebo "Add Server"
3. Zadat: `https://github.com/motherduckdb/mcp-server-motherduck`
4. Potvrdit

#### Varianta B: CLI (pro pokročilé)

```bash
# Instalace Smithery CLI (jednorázově)
npm install -g @smithery/cli

# Přihlášení
smithery login

# Publikace
smithery publish https://github.com/motherduckdb/mcp-server-motherduck
```

### Krok 4: Validace (1 minuta)

```bash
# Test instalace přes Smithery
npx @smithery/cli install mcp-server-motherduck

# Test funkčnosti
uvx mcp-server-motherduck --help
```

## ✅ To je vše!

Váš server je nyní na Smithery a kdokoli ho může nainstalovat pomocí:

```bash
npx @smithery/cli install mcp-server-motherduck
```

## 🔄 Aktualizace verze v budoucnu

Při vydání nové verze (např. 0.6.5):

```bash
# 1. Aktualizovat verze v souborech
# src/mcp_server_motherduck/configs.py
SERVER_VERSION = "0.6.5"

# pyproject.toml
version = "0.6.5"

# server.json
"version": "0.6.5"
"packages[0].version": "0.6.5"

# 2. Build a publikace
uv build
uv publish

# 3. Git release
git add .
git commit -m "Release v0.6.5"
git tag v0.6.5
git push origin main --tags

# 4. Smithery automaticky detekuje novou verzi!
```

## 📚 Další zdroje

- **Kompletní průvodce**: `SMITHERY_DEPLOYMENT.md`
- **Checklist**: `.smithery/checklist.md`
- **Smithery Docs**: https://smithery.ai/docs
- **GitHub Repo**: https://github.com/motherduckdb/mcp-server-motherduck

## 🆘 Pomoc

Problémy? Zkontrolujte:
1. PyPI balíček je publikován: https://pypi.org/project/mcp-server-motherduck/
2. GitHub repo je veřejný
3. `server.json` je validní

Pro podporu:
- GitHub Issues: https://github.com/motherduckdb/mcp-server-motherduck/issues
- Smithery Support: https://smithery.ai/support
