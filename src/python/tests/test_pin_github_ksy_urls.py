"""Unit tests for ``scripts/pin_github_ksy_urls.py`` (no network)."""

from __future__ import annotations

import importlib.util
import sys
from pathlib import Path


def _load_pin_module():
    root = Path(__file__).resolve().parents[3]
    path = root / "scripts" / "pin_github_ksy_urls.py"
    name = "pin_github_ksy_urls"
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    spec.loader.exec_module(mod)  # type: ignore[union-attr]
    return mod


M = _load_pin_module()


def _branch(sha: str, when: str) -> dict:
    return {
        "name": "irrelevant",
        "commit": {
            "sha": sha,
            "commit": {
                "committer": {"date": when},
                "author": {"date": when},
            },
        },
    }


def test_repo_key() -> None:
    assert M.repo_key("OpenKotOR", "PyKotor") == ("openkotor", "pykotor")
    assert M.repo_key("x", "Y.git") == ("x", "y")


def test_pick_tips_newer_prefer_main() -> None:
    master = _branch("a" * 40, "2020-01-01T00:00:00Z")
    main = _branch("b" * 40, "2024-01-01T00:00:00Z")
    r = M.pick_branch_tips(master, main, "newer")
    assert r is not None
    assert r[0] == "main"
    assert r[1] == "b" * 40


def test_pick_tips_newer_prefer_master() -> None:
    master = _branch("c" * 40, "2025-01-01T00:00:00Z")
    main = _branch("d" * 40, "2020-01-01T00:00:00Z")
    r = M.pick_branch_tips(master, main, "newer")
    assert r is not None
    assert r[0] == "master"
    assert r[1] == "c" * 40


def test_pick_tips_master_strategy_both() -> None:
    master = _branch("a" * 40, "2020-01-01T00:00:00Z")
    main = _branch("b" * 40, "2024-01-01T00:00:00Z")
    r = M.pick_branch_tips(master, main, "master")
    assert r is not None
    assert r[0] == "master"
    assert r[1] == "a" * 40


def test_pick_tips_only_master() -> None:
    master = _branch("e" * 40, "2020-01-01T00:00:00Z")
    r = M.pick_branch_tips(master, None, "newer")
    assert r is not None
    assert r[0] == "master"
    assert r[1] == "e" * 40


def test_apply_pin_map_merges_master_and_main_urls() -> None:
    k = M.repo_key("Foo", "Bar")
    pr = M.PinResult("Foo", "Bar", "f" * 40, "test", None)
    text = (
        "x https://github.com/Foo/Bar/blob/master/a.py#L1-L2 y "
        "z https://github.com/Foo/Bar/tree/main/specs/ z"
    )
    new, _w = M.apply_pin_map_to_text(text, {k: pr})
    assert "blob/master" not in new
    assert "tree/main" not in new
    assert f"blob/{'f' * 40}/a.py#L1-L2" in new
    assert f"tree/{'f' * 40}/specs/" in new


def test_collect_keys_and_displays() -> None:
    t = "see https://github.com/Org/Name/blob/master/README.md#L3"
    keys, disp = M.collect_keys_and_displays(t)
    k = M.repo_key("Org", "Name")
    assert k in keys
    assert disp[k] == ("Org", "Name")
