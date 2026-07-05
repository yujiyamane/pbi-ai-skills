---
name: pbi-dashboard-generator
description: "Generate a complete Power BI dashboard (PBIP project with TMDL semantic model and PBIR report) from a /*FACTORY*/ Config Block. Takes a ready config block, runs the drafter pipeline (parse_config → run_factory), and outputs a PBIP dashboard that opens in Power BI Desktop. Use when the user says: 'generate dashboard', 'build dashboard from config', 'run factory', 'create dashboard', 'ダッシュボード生成', or provides a /*FACTORY*/ config block with generation intent. If the user only has raw data and no config block yet, use pbi-config-drafter first."
---

# PBI Dashboard Generator

This skill routes to the full pbi-drafter instructions.

Read and follow `../../pbi-drafter/SKILL.md` (path relative to this file). All scripts, templates, and references it mentions live in that directory.

This skill only generates — it does not draft configs. Route config drafting to `pbi-config-drafter`.
