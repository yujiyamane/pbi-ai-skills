---
name: pbi-config-drafter
description: "Analyse a CSV/Excel dataset and auto-generate a Dashboard Drafter Config Block. Reads column headers, data types, unique value counts, and value ranges to classify columns into SUM/CNT/AVG/KEY/OTHER/DATE slots, then proposes a Config Block for user approval. Does NOT generate the dashboard — only drafts the config. Use when the user says: 'draft config', 'analyse this CSV for dashboard', 'create config from data', 'generate config block', 'propose config', 'what config should I use for this data', or provides a CSV/Excel path with config-drafting intent."
---

# PBI Config Drafter

This skill routes to the full pbi-drafter-configurator instructions.

Read and follow `${CLAUDE_PLUGIN_ROOT}/pbi-drafter-configurator/SKILL.md` (relative to this file: `../../pbi-drafter-configurator/SKILL.md`). All scripts and references it mentions live in that directory.

If the user already has a `/*FACTORY*/` Config Block and wants the dashboard built, hand over to `pbi-dashboard-generator` instead.
