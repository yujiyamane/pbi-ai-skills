import json
import subprocess
import sys
from pathlib import Path

SCRIPTS = Path(__file__).parent.parent / "scripts"
import pytest
from conftest import FIXTURE_ROOT

PBIP = FIXTURE_ROOT / "HR_Dashboard" / "HR_Dashboard.pbip"
pytestmark = pytest.mark.skipif(not PBIP.exists(), reason="requires local PBIP fixture (set PBI_FIXTURE_ROOT)")


def test_parse_pbip_outputs_valid_json():
    result = subprocess.run(
        [sys.executable, str(SCRIPTS / "parse_pbip.py"), str(PBIP)],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, f"stderr: {result.stderr}"
    data = json.loads(result.stdout)
    assert data["name"] == "HR_Dashboard"


def test_parse_pbip_json_has_pages():
    result = subprocess.run(
        [sys.executable, str(SCRIPTS / "parse_pbip.py"), str(PBIP)],
        capture_output=True,
        text=True,
    )
    data = json.loads(result.stdout)
    assert len(data["report"]["pages"]) == 6


def test_parse_pbip_json_has_tables():
    result = subprocess.run(
        [sys.executable, str(SCRIPTS / "parse_pbip.py"), str(PBIP)],
        capture_output=True,
        text=True,
    )
    data = json.loads(result.stdout)
    assert len(data["model"]["tables"]) > 0


def test_parse_pbip_exits_nonzero_on_missing_file():
    result = subprocess.run(
        [sys.executable, str(SCRIPTS / "parse_pbip.py"), "nonexistent.pbip"],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0


def test_parse_pbip_json_schema():
    result = subprocess.run(
        [sys.executable, str(SCRIPTS / "parse_pbip.py"), str(PBIP)],
        capture_output=True,
        text=True,
    )
    data = json.loads(result.stdout)
    assert "name" in data
    assert "pbip_path" in data
    assert "report" in data
    assert "model" in data
    assert "bookmarks" in data
    page = data["report"]["pages"][0]
    assert "displayName" in page
    assert "page_id" in page
    assert "visuals" in page
    table = data["model"]["tables"][0]
    assert "name" in table
    assert "columns" in table
    assert "measures" in table
