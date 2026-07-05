import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent / "scripts"))

# Integration tests parse a real PBIP project. Point PBI_FIXTURE_ROOT at a
# folder containing HR_Dashboard/ and Finance_Dashboard/ PBIP exports; tests
# that need them skip when the variable is unset or the fixture is absent.
FIXTURE_ROOT = Path(os.environ.get("PBI_FIXTURE_ROOT", "_pbip_fixtures_not_configured"))
