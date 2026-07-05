import pytest
from pathlib import Path
from pbip_loader import load_pbip

from conftest import FIXTURE_ROOT

HR = FIXTURE_ROOT / "HR_Dashboard"
pytestmark = pytest.mark.skipif(not HR.exists(), reason="requires local PBIP fixture (set PBI_FIXTURE_ROOT)")
PBIP = HR / "HR_Dashboard.pbip"


def test_load_pbip_returns_name():
    result = load_pbip(PBIP)
    assert result["name"] == "HR_Dashboard"


def test_load_pbip_returns_report_path():
    result = load_pbip(PBIP)
    assert result["report_path"] == HR / "HR_Dashboard.Report"


def test_load_pbip_returns_model_path():
    result = load_pbip(PBIP)
    assert result["model_path"] == HR / "HR_Dashboard.SemanticModel"


def test_load_pbip_report_folder_exists():
    result = load_pbip(PBIP)
    assert result["report_path"].is_dir()


def test_load_pbip_model_folder_exists():
    result = load_pbip(PBIP)
    assert result["model_path"].is_dir()


def test_load_pbip_raises_on_invalid_path():
    with pytest.raises(FileNotFoundError):
        load_pbip(Path("nonexistent.pbip"))
