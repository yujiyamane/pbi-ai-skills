from pathlib import Path
from pbip_loader import load_pbip
from report_parser import parse_report

import pytest
from conftest import FIXTURE_ROOT

HR = FIXTURE_ROOT / "HR_Dashboard"
pytestmark = pytest.mark.skipif(not HR.exists(), reason="requires local PBIP fixture (set PBI_FIXTURE_ROOT)")
PBIP = HR / "HR_Dashboard.pbip"


def test_parse_report_returns_pbir_format():
    paths = load_pbip(PBIP)
    result = parse_report(paths["report_path"])
    assert result["format"] == "PBIR"


def test_parse_report_returns_4_pages():
    paths = load_pbip(PBIP)
    result = parse_report(paths["report_path"])
    assert len(result["pages"]) == 6


def test_parse_report_page_order():
    paths = load_pbip(PBIP)
    result = parse_report(paths["report_path"])
    names = [p["displayName"] for p in result["pages"]]
    assert names == ["Summery", "Details", "AdHoc", "Visuals", "Drill through", "Colors"]


def test_parse_report_pages_have_visuals():
    paths = load_pbip(PBIP)
    result = parse_report(paths["report_path"])
    for page in result["pages"]:
        assert "visuals" in page
        assert isinstance(page["visuals"], list)


def test_parse_report_visuals_have_required_fields():
    paths = load_pbip(PBIP)
    result = parse_report(paths["report_path"])
    for page in result["pages"]:
        for v in page["visuals"]:
            assert "id" in v
            assert "visualType" in v
            assert "position" in v
