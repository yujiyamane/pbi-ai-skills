# pbi-ai-skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Tests](https://img.shields.io/badge/tests-350%20passing-brightgreen)](#)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-blue)](#)
[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-compatible-blue)](#)

**Power BI × AI agent skills for Claude Code and GitHub Copilot.**

A monorepo of AI-native skills that automate the full Power BI development lifecycle — from dataset analysis and dashboard generation to documentation, quality testing, and deployment.

---

## Skills

| Skill | Description | Status |
|---|---|---|
| [pbi-drafter](pbi-drafter/) | Generate a PBIP dashboard from a `/*FACTORY*/` config block | ✅ Stable — 350 tests |
| [pbi-drafter-configurator](pbi-drafter-configurator/) | Analyse a CSV/Excel file and auto-generate a config block | ✅ Stable |
| [pbi-user-guide-drafter](pbi-user-guide-drafter/) | Generate a professional DOCX user guide from a PBIP folder | ✅ Stable |
| [pbi-tester](pbi-tester/) | Static quality analysis — 50+ checks across 10 categories | ✅ Stable |
| [pbi-deployer](pbi-deployer/) | One-command deploy via fabric-cicd | ✅ Stable |
| [pbi-rls-auditor](pbi-rls-auditor/) | RLS role testing and audit trail generation | 🚧 Coming soon |
| [pbi-optimiser](pbi-optimiser/) | Performance profiling and optimisation recommendations | 🚧 Coming soon |

---

## Quick Start

### Claude Code

Install all skills:

```bash
claude skills install https://github.com/yujiyamane/pbi-ai-skills
```

Or install a single skill:

```bash
claude skills install https://github.com/yujiyamane/pbi-ai-skills/pbi-drafter
```

Then use in a conversation:

```
Use the pbi-drafter-configurator skill to analyse my CSV at C:\data\sales.csv
```

### GitHub Copilot

Skills are available in `.github/skills/` for Copilot workspace compatibility. Reference them in your Copilot Chat:

```
#skills/pbi-drafter-configurator Analyse this CSV for a dashboard config
```

### Cursor / Codex

Copy the `SKILL.md` from the relevant skill folder into your project context, or reference it as a rules file.

---

## Skill Details

### pbi-drafter

Generates a full Power BI Project (PBIP) from a `/*FACTORY ... */` Config Block. The pipeline covers:

- Config parsing and validation
- M Query generation (Power Query)
- TMDL semantic model (tables, columns, measures, format strings)
- PBIR report layout (pages, visuals, slicers, KPI cards)
- DAX measures

**350 TDD tests** cover every pipeline step.

```
python -m pytest pbi-drafter/tests/ -q
```

### pbi-drafter-configurator

Analyses a CSV or Excel file and classifies columns into SUM/CNT/AVG/KEY/OTHER/DATE slots. Outputs a ready-to-use `/*FACTORY ... */` config block for pbi-drafter.

### pbi-user-guide-drafter

Parses a PBIP folder (PBIR/TMDL/TMSL) and generates a professional Word document with:
- Document control, background, data sources
- Page-by-page guide with KPI definitions
- Boilerplate sections (access, tips, export)
- Screenshot placeholders (Phase 1) or live screenshots via Playwright (Phase 2)

**Template:** `pbi-user-guide-drafter/assets/template_sample.docx` — replace with your branded template.

### pbi-tester

Static quality analysis with no external tools required. Reads PBIP files directly and runs:

- **Layout & Visual Design** — page count, hidden pages, visual density
- **Text Quality** — title casing, placeholder text, alt text
- **Format Strings** — currency, percentage, date, blank formats
- **Accessibility** — colour contrast, tab order, font size
- **Design Consistency** — theme, fonts, colour palette
- **TMDL Model Quality** — descriptions, naming conventions, calculated columns
- **Relationships** — bidirectional, inactive, many-to-many
- **Security** — RLS roles, sensitive column names
- **Performance Signals** — measure complexity, CALCULATE nesting
- **Cross-Layer Consistency** — unused measures, broken visual references

### pbi-deployer

One-command deploy to Power BI Service or Microsoft Fabric via `fabric-cicd`. Includes pre-deployment validation and post-deployment status check.

```bash
pip install fabric-cicd && az login
```

---

## Repository Structure

```
pbi-ai-skills/
├── pbi-drafter/              # Dashboard generator (PBIP output)
│   ├── SKILL.md
│   ├── src/                  # Pipeline source (Python)
│   ├── tests/                # 350 TDD tests
│   ├── template/             # PBIP golden master template
│   └── data/                 # Sample CSV datasets
├── pbi-drafter-configurator/ # Config block drafter
│   └── SKILL.md
├── pbi-user-guide-drafter/   # DOCX user guide generator
│   ├── SKILL.md
│   ├── scripts/              # PBIP parsers + DOCX writer
│   ├── assets/               # Boilerplate .md + template_sample.docx
│   └── tests/
├── pbi-tester/               # Static quality analyser
│   └── SKILL.md
├── pbi-deployer/             # fabric-cicd deploy wrapper
│   └── SKILL.md
├── pbi-rls-auditor/          # Coming soon
├── pbi-optimiser/            # Coming soon
├── .github/skills/           # Copilot-compatible skill copies
├── sanitize.ps1              # Sanitisation script for clean/ export
└── index.html                # GitHub Pages
```

---

## Installation

```bash
pip install python-docx        # pbi-user-guide-drafter
pip install fabric-cicd        # pbi-deployer
# Optional — for live screenshot capture:
pip install playwright && playwright install chromium
```

---

## Roadmap

- [ ] `pbi-rls-auditor` — RLS role testing with DAX evaluation + audit trail export
- [ ] `pbi-optimiser` — VertiPaq Analyser integration, measure DAX profiling, aggregation recommendations
- [ ] CI/CD integration — GitHub Actions workflow for automated quality gates on PBIP changes

---

## License

MIT — see [LICENSE](LICENSE).

---

## Contributing

PRs welcome. Skills must include a `SKILL.md` and, where applicable, a `tests/` folder with passing tests.
