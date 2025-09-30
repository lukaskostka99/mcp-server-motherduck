# .smithery - Smithery Deployment Files

Tento adresář obsahuje dokumentaci a nástroje pro nasazení `mcp-server-motherduck` na platformu Smithery.

## 📁 Obsah adresáře

### Dokumentace

- **`QUICKSTART.md`** - Rychlý průvodce pro nasazení na Smithery za 5 minut
- **`../SMITHERY_DEPLOYMENT.md`** - Kompletní průvodce nasazením s detailními pokyny
- **`checklist.md`** - Kontrolní seznam pro před-publikační validaci

### Nástroje

- **`release.sh`** - Automatizovaný skript pro vydání nové verze

## 🚀 Rychlý start

### První nasazení na Smithery

1. Přečtěte si **QUICKSTART.md**
2. Postupujte podle kroků v **checklist.md**
3. Použijte web interface nebo CLI pro publikaci

### Publikace nové verze

```bash
# Použijte release script
./.smithery/release.sh

# Nebo manuálně podle SMITHERY_DEPLOYMENT.md
```

## 📋 Workflow pro vydání verze

### Automatizovaný způsob (doporučeno)

```bash
cd /Users/lukaskostka/motherduck-mcp/mcp-server-motherduck
./.smithery/release.sh
```

Script provede:
1. ✅ Aktualizaci verzí ve všech souborech
2. ✅ Build balíčku
3. ✅ Publikaci na PyPI (volitelně)
4. ✅ Git commit a tag
5. ✅ Push na GitHub (volitelně)

### Manuální způsob

Viz **SMITHERY_DEPLOYMENT.md** - Krok 4: Aktualizace verze

## 🔍 Kontrola před publikací

Vždy použijte **checklist.md** pro ověření, že:
- Verze jsou synchronizované
- Server.json je validní
- Balíček funguje lokálně
- Dokumentace je aktuální

## 📚 Další zdroje

### Smithery
- [Smithery.ai](https://smithery.ai)
- [Smithery Documentation](https://smithery.ai/docs)
- [MCP Server Specification](https://spec.modelcontextprotocol.io/)

### Python Package
- [PyPI Package](https://pypi.org/project/mcp-server-motherduck/)
- [uv Documentation](https://docs.astral.sh/uv/)

### GitHub
- [GitHub Repository](https://github.com/motherduckdb/mcp-server-motherduck)
- [Releases](https://github.com/motherduckdb/mcp-server-motherduck/releases)

## 🆘 Řešení problémů

### Běžné problémy

**Server se nezobrazuje na Smithery**
- Zkontrolujte `server.json` validitu
- Ověřte, že GitHub repo je veřejný
- Ujistěte se, že balíček je na PyPI

**Release script selhává**
- Ujistěte se, že máte `uv` nainstalovaný
- Zkontrolujte, že máte PyPI credentials
- Ověřte, že jste v root adresáři projektu

**Verze se neaktualizuje**
- Ověřte, že všechny tři soubory mají stejnou verzi
- Zkontrolujte, že nová verze je na PyPI
- Vytvořte GitHub release s tagem

### Podpora

Pro technickou podporu:
- **GitHub Issues**: https://github.com/motherduckdb/mcp-server-motherduck/issues
- **Smithery Support**: https://smithery.ai/support
- **MotherDuck Community**: https://motherduck.com/community

## 📝 Poznámky pro maintainery

### Synchronizace verzí

Verze musí být aktualizována ve třech souborech:
1. `pyproject.toml` - `version = "X.Y.Z"`
2. `src/mcp_server_motherduck/configs.py` - `SERVER_VERSION = "X.Y.Z"`
3. `server.json` - `version` a `packages[0].version`

Release script to automaticky zajistí.

### PyPI publikace

Vyžaduje PyPI token:
```bash
# Nastavení tokenu
export UV_PUBLISH_TOKEN=pypi-YOUR_TOKEN_HERE

# Nebo použití při publikaci
uv publish --token pypi-YOUR_TOKEN_HERE
```

### GitHub Releases

Po každé publikaci vytvořte GitHub Release:
1. Jděte na: https://github.com/motherduckdb/mcp-server-motherduck/releases/new
2. Vyberte tag: `vX.Y.Z`
3. Napište Release notes
4. Publikujte

Smithery automaticky detekuje novou verzi z GitHub releases.

---

**Poslední aktualizace**: 2025-09-30  
**Verze**: 0.6.4
