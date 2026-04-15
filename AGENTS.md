# Agent brief — BioWare Kaitai formats

This file is the **compact hand-off** for coding agents. **Full project rules** (compiler usage, layout, validation, commits) live in [`.cursorrules`](.cursorrules). **Do not duplicate** that document here.

## Goals (alignment)

- **Binary on-disk wire** in `formats/**/*.ksy` only; avoid modeling plaintext/XML/JSON/CSV interchange in Kaitai unless the maintainers explicitly expand scope.
- **`meta.xref` / `doc` citations** — Prefer **canonical upstreams** on **`master`** where line anchors are maintained:
  - Engine / Aurora: `https://github.com/xoreos/xoreos/blob/master/…` and `https://github.com/xoreos/xoreos-tools/blob/master/…`
  - PyKotor: `https://github.com/OpenKotOR/PyKotor/blob/master/…` (and `tree/master` for directory links)
  - Other established upstreams: `modawan/reone`, `KobaltBlu/KotOR.js`, `NickHugi/Kotor.NET`, etc.
- **Shared modules** under `formats/Common/` — `meta.id` and `meta.imports` last path segment must be **`lower_snake_case`** (schema + KSC on Windows).
- **Coverage matrix** — [`docs/XOREOS_FORMAT_COVERAGE.md`](docs/XOREOS_FORMAT_COVERAGE.md) tracks xoreos ↔ `.ksy` mapping and audit steps.

## URL tooling (order of operations)

| Script | Purpose |
|--------|---------|
| [`scripts/rewrite_canonical_github_urls.py`](scripts/rewrite_canonical_github_urls.py) | Rewrites known **fork / pin** URL prefixes in `formats/**/*.ksy` to the **canonical `master`** URLs above (run after a pin pass or when forks creep back in). |
| [`scripts/apply_github_pins.py`](scripts/apply_github_pins.py) | **Inverse:** replaces upstream `…/blob/master/` with **commit-pinned forks** per [`scripts/data/upstream_github_pins.json`](scripts/data/upstream_github_pins.json). Use only when you intentionally want SHAs for regression snapshots — then re-run `rewrite_canonical_github_urls.py` if the repo policy is canonical `master`. |
| [`scripts/verify_ksy_urls.py`](scripts/verify_ksy_urls.py) | `--check-xoreos-github-line-ranges` — validates `xoreos/xoreos` and `xoreos-tools` **`blob/master` `#L`** bands against `raw.githubusercontent.com`. `--check-github-blob-line-ranges` — validates **40-char commit** `blob/<sha>/…#L` anchors. `--verify` — slow HTTP `HEAD` over all extracted URLs. |

**Suggested check after `.ksy` edits:**

```text
python scripts/verify_ksy_urls.py --check-xoreos-github-line-ranges --also docs/XOREOS_FORMAT_COVERAGE.md
python -m pytest src/python/tests/test_kaitai_compile_smoke.py
```

## Learned preferences

- Keep **wire** documentation on the owning type/enum; consumers link to **`formats/Common/`** instead of pasting duplicate upstream mirrors.
- For KotOR alignment, **Ghidra / PC binary** evidence outranks wiki-only guesses when layout or enum semantics are ambiguous; mark **`TODO: VERIFY`** when the binary is unclear.
- **Submodule / fork caveat:** `.gitmodules` may point `vendor/xoreos*` at forks; line numbers can diverge from `github.com/xoreos/xoreos` `master`. In-tree proof links still target **upstream `master`** unless a doc explicitly pins a SHA for a regression snapshot.

## Root layout

Allowed root files include `README.md`, `.gitignore`, `.cursorrules`, **`AGENTS.md`**, `LICENSE` — see `.cursorrules` §1. Keep scratch **`ksc`** output under `tmp_ksc*/` or `src/**/kaitai_generated/`, not the repo root.
