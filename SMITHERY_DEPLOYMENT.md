# Průvodce nasazením na Smithery

Tento dokument obsahuje pokyny pro nasazení `mcp-server-motherduck` na platformu Smithery.

## Předpoklady

Váš MCP server je připraven k nasazení na Smithery, pokud splňuje následující podmínky:

- ✅ **Balíček je publikován na PyPI** (`mcp-server-motherduck` verze 0.6.4)
- ✅ **Existuje soubor `server.json`** s platnou konfigurací
- ✅ **GitHub repository** je veřejný (`https://github.com/motherduckdb/mcp-server-motherduck`)
- ✅ **README.md** obsahuje dokumentaci

## Krok 1: Ověření server.json

Soubor `server.json` je klíčový pro Smithery. Ujistěte se, že obsahuje:

```json
{
  "$schema": "https://static.modelcontextprotocol.io/schemas/2025-07-09/server.schema.json",
  "name": "io.github.motherduckdb/mcp-server-motherduck",
  "description": "Fast analytics and data processing with DuckDB and MotherDuck",
  "status": "active",
  "repository": {
    "url": "https://github.com/motherduckdb/mcp-server-motherduck",
    "source": "github"
  },
  "version": "0.6.4",
  "packages": [
    {
      "registry_type": "pypi",
      "registry_base_url": "https://pypi.org",
      "identifier": "mcp-server-motherduck",
      "version": "0.6.4",
      ...
    }
  ]
}
```

✅ Váš soubor je již kompletní!

## Krok 2: Publikace na Smithery

### Metoda A: Přes Smithery Web Interface

1. Navštivte [Smithery.ai](https://smithery.ai)
2. Přihlaste se pomocí GitHub účtu
3. Klikněte na "Submit Server" nebo "Add Server"
4. Zadejte URL vašeho GitHub repository: `https://github.com/motherduckdb/mcp-server-motherduck`
5. Smithery automaticky detekuje `server.json` a provede validaci
6. Potvrďte a publikujte

### Metoda B: Přes Smithery CLI

```bash
# Instalace Smithery CLI (vyžaduje Node.js 18+)
npm install -g @smithery/cli

# Přihlášení
smithery login

# Publikace serveru z repository
smithery publish https://github.com/motherduckdb/mcp-server-motherduck

# NEBO publikace z lokálního adresáře
cd /Users/lukaskostka/motherduck-mcp/mcp-server-motherduck
smithery publish .
```

## Krok 3: Testování po publikaci

Po publikaci můžete server nainstalovat pomocí Smithery CLI:

```bash
# Instalace serveru přes Smithery
npx @smithery/cli install mcp-server-motherduck

# Nebo přímo pomocí uvx (jak je v README)
uvx mcp-server-motherduck --db-path md: --motherduck-token <VÁŠ_TOKEN>
```

### Testování v Claude Desktop

```json
{
  "mcpServers": {
    "mcp-server-motherduck": {
      "command": "uvx",
      "args": [
        "mcp-server-motherduck",
        "--db-path",
        "md:",
        "--motherduck-token",
        "<VÁŠ_MOTHERDUCK_TOKEN>"
      ]
    }
  }
}
```

## Krok 4: Aktualizace verze

Při vydání nové verze:

1. **Aktualizujte verzi v `pyproject.toml`:**
   ```toml
   version = "0.6.5"  # nová verze
   ```

2. **Aktualizujte verzi v `server.json`:**
   ```json
   {
     "version": "0.6.5",
     "packages": [
       {
         "version": "0.6.5",
         ...
       }
     ]
   }
   ```

3. **Aktualizujte verzi v `src/mcp_server_motherduck/configs.py`:**
   ```python
   SERVER_VERSION = "0.6.5"
   ```

4. **Publikujte na PyPI:**
   ```bash
   # Build balíčku
   uv build
   
   # Publikace na PyPI (vyžaduje PyPI credentials)
   uv publish
   ```

5. **Commitněte změny a pushnete na GitHub:**
   ```bash
   git add .
   git commit -m "Release version 0.6.5"
   git tag v0.6.5
   git push origin main --tags
   ```

6. **Smithery automaticky detekuje novou verzi** z GitHub releases

## Verifikace nasazení

Po úspěšné publikaci na Smithery:

1. Server bude viditelný na [Smithery.ai](https://smithery.ai)
2. Uživatelé ho mohou nainstalovat pomocí:
   ```bash
   npx @smithery/cli install mcp-server-motherduck
   ```
3. Server bude dostupný v Smithery katalogu MCP serverů

## Údržba a podpora

### Badge pro README

Můžete přidat Smithery badge do README.md:

```markdown
[![Smithery](https://smithery.ai/badge/mcp-server-motherduck)](https://smithery.ai/server/mcp-server-motherduck)
```

### Monitoring

- Sledujte stažení a usage na Smithery dashboard
- Reagujte na issues a feedback od uživatelů
- Pravidelně aktualizujte dependencies a DuckDB verze

## Řešení problémů

### Server se nezobrazuje na Smithery

1. Zkontrolujte, že `server.json` má platný formát
2. Ověřte, že GitHub repository je veřejný
3. Ujistěte se, že balíček existuje na PyPI

### Chyba při instalaci přes Smithery CLI

```bash
# Zkuste vyčistit cache
npx @smithery/cli cache clear

# Znovu nainstalujte
npx @smithery/cli install mcp-server-motherduck --force
```

### Verze se neaktualizuje

1. Ujistěte se, že nová verze je na PyPI
2. Aktualizujte `server.json` s novou verzí
3. Vytvořte nový GitHub release s tagem

## Další zdroje

- [Smithery Documentation](https://smithery.ai/docs)
- [MCP Server Specification](https://spec.modelcontextprotocol.io/)
- [MotherDuck Documentation](https://motherduck.com/docs)

## Kontakty

Pro otázky týkající se Smithery nasazení:
- Smithery Support: https://smithery.ai/support
- GitHub Issues: https://github.com/motherduckdb/mcp-server-motherduck/issues
