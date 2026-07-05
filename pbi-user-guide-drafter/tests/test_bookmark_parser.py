from pathlib import Path
from pbip_loader import load_pbip
from bookmark_parser import parse_bookmarks

import pytest
from conftest import FIXTURE_ROOT

HR = FIXTURE_ROOT / "HR_Dashboard"
pytestmark = pytest.mark.skipif(not HR.exists(), reason="requires local PBIP fixture (set PBI_FIXTURE_ROOT)")
PBIP = HR / "HR_Dashboard.pbip"


def test_parse_bookmarks_returns_list():
    paths = load_pbip(PBIP)
    result = parse_bookmarks(paths["report_path"])
    assert isinstance(result, list)


def test_parse_bookmarks_no_error_when_missing():
    result = parse_bookmarks(Path("C:/nonexistent/path"))
    assert result == []
