# Kaitai Struct Architecture for BioWare Formats

## Overview

This document describes how we use Kaitai Struct to generate parsers that match PyKotor's API patterns.

## Kaitai Struct Limitations

**CRITICAL**: Kaitai Struct is a **parser generator only** - it generates READ code, not WRITE code.

- ✅ Generates efficient binary parsers for all languages
- ❌ Does NOT generate serializers/writers
- ❌ Does NOT generate high-level object models

## Architecture Strategy

### Layer 1: Kaitai-Generated Parsers (READ-ONLY)

Kaitai Struct generates low-level parsers that read binary formats into data structures.

**Example**: `gff.ksy` compiles to:

- `gff.py` (Python)
- `Gff.cs` (C#)
- `gff.go` (Go)
- etc. for 12+ languages

These parsers provide:

- Direct access to binary structure
- Lazy parsing (reads only what's accessed)
- Memory-efficient processing

### Layer 2: Wrapper/Adapter Classes (Language-Specific)

We create wrapper classes that:

1. Use Kaitai parsers for reading
2. Provide PyKotor-compatible API
3. Handle format conversions (XML, JSON)
4. Provide write functionality (separate implementation)

**Python Example**:

```python
# formats/python/wrappers/are_wrapper.py
from kaitai_generated.are import Are as KaitaiAre
from pykotor.resource.generics.base import GenericBase

class ARE(GenericBase):
    """PyKotor-compatible ARE class using Kaitai parser"""
    
    @classmethod
    def from_binary(cls, data: bytes) -> ARE:
        """Read ARE from binary using Kaitai parser"""
        kaitai_obj = KaitaiAre.from_bytes(data)
        return cls._from_kaitai(kaitai_obj)
    
    @classmethod
    def _from_kaitai(cls, kaitai_obj: KaitaiAre) -> ARE:
        """Convert Kaitai structure to PyKotor-style object"""
        are = cls()
        # Extract fields from GFF structure via Kaitai parser
        gff = kaitai_obj.gff_data
        # ... populate ARE fields from GFF ...
        return are
```

### Layer 3: API Functions (PyKotor-Compatible)

Create API functions matching PyKotor patterns:

```python
def read_are(source, offset=0, size=None) -> ARE:
    """PyKotor-compatible read function"""
    # Detect format (binary, XML, JSON)
    # Use appropriate parser
    # Return ARE object

def write_are(are, target, format=ResourceType.GFF):
    """Write ARE (requires separate writer implementation)"""
    # Convert ARE to GFF structure
    # Serialize to binary/XML/JSON

def bytes_are(are, format=ResourceType.GFF) -> bytes:
    """Get ARE as bytes in specified format"""
    # Use write_are to temp buffer
    # Return bytes
```

## Testing Strategy

### Test Layer 1: Kaitai Parser Tests

Verify Kaitai parsers correctly read binary data:

```python
def test_kaitai_gff_parser():
    """Test that Kaitai GFF parser reads structure correctly"""
    kaitai_gff = Gff.from_file("test.gff")
    assert kaitai_gff.header.file_type == "GFF "
    assert kaitai_gff.header.file_version == "V3.2"
```

### Test Layer 2: Wrapper Compatibility Tests

Verify wrappers produce PyKotor-equivalent output:

```python
def test_are_wrapper_matches_pykotor():
    """Test that wrapper produces same result as PyKotor"""
    data = read_test_file("test.are")
    
    # Parse with Kaitai wrapper
    kaitai_are = ARE.from_binary(data)
    
    # Parse with PyKotor
    pykotor_are = pykotor_read_are(data)
    
    # Compare all fields
    assert kaitai_are.tag == pykotor_are.tag
    assert kaitai_are.alpha_test == pykotor_are.alpha_test
    # ... etc for all fields ...
```

### Test Layer 3: Cross-Language Tests

Verify all language implementations produce equivalent results:

```python
def test_cross_language_parsing():
    """Test that Python, C#, Go, etc. all parse identically"""
    data = read_test_file("test.gff")
    
    # Parse with Python
    py_result = parse_python(data)
    
    # Parse with C# (via subprocess)
    cs_result = parse_csharp(data)
    
    # Parse with Go (via subprocess)
    go_result = parse_go(data)
    
    # All should produce identical JSON representation
    assert py_result == cs_result == go_result
```

## Implementation Plan

### Phase 1: Complete .ksy Definitions ✅

- [x] Refactor all GFF generics to import base GFF
- [x] Remove duplication across formats
- [x] Fix XML variant imports
- [ ] Validate all .ksy files compile

### Phase 2: Python Integration (Priority)

- [ ] Generate Python code from all .ksy files
- [ ] Create Python wrapper classes matching PyKotor API
- [ ] Implement `read_<format>` functions
- [ ] Create comprehensive test suite matching PyKotor tests
- [ ] Ensure 100% PyKotor test compatibility

### Phase 3: Multi-Language Support

- [ ] Generate code for all 12+ languages:
  - C# (for Andastra compatibility)
  - JavaScript/TypeScript (for web tools)
  - Go (for performance-critical tools)
  - Rust (for ultra-safe parsing)
  - Java, C++, Ruby, PHP, Lua, Perl, Nim, Swift
- [ ] Create language-specific wrappers/adapters
- [ ] Create cross-language test harness
- [ ] Verify output equivalence across languages

### Phase 4: Writer Implementation (Separate)

Since Kaitai doesn't generate writers, we need separate strategy:

- Option A: Manual writer implementation per language
- Option B: Use PyKotor writers, wrap for other languages
- Option C: Create writer code generator (separate tool)

## Directory Structure

```
bioware-kaitai-formats/
├── formats/              # .ksy format definitions
│   ├── GFF/
│   │   ├── GFF.ksy      # Base GFF format
│   │   └── Generics/    # GFF-based formats
│   │       ├── ARE/
│   │       │   ├── ARE.ksy       # Binary format
│   │       │   └── ARE_XML.ksy   # XML variant
│   │       └── UTC/
│   ├── Common/
│   │   └── bioware_common.ksy  # Shared types/enums
│   └── ...
├── src/                  # Generated code
│   ├── python/
│   │   ├── kaitai_generated/  # Raw Kaitai output
│   │   │   ├── gff.py
│   │   │   ├── are.py
│   │   │   └── ...
│   │   ├── wrappers/          # PyKotor-compatible wrappers
│   │   │   ├── are_wrapper.py
│   │   │   ├── utc_wrapper.py
│   │   │   └── ...
│   │   └── tests/             # Test suite
│   │       ├── test_are.py    # Matches PyKotor tests
│   │       ├── test_utc.py
│   │       └── ...
│   ├── csharp/
│   │   ├── KaitaiGenerated/
│   │   ├── Wrappers/
│   │   └── Tests/
│   └── ...
├── scripts/
│   ├── generate_code.ps1     # Compile all .ksy files
│   ├── generate_wrappers.py  # Generate wrapper classes
│   └── run_tests.ps1         # Run all tests
└── vendor/
    └── PyKotor/              # Reference implementation
```

## Benefits of This Approach

1. **Leverages Kaitai Strengths**: Excellent parsing, multi-language support
2. **Maintains PyKotor Compatibility**: Wrappers provide identical API
3. **Multi-Language Support**: Single .ksy generates 12+ languages
4. **Testable**: Clear layers, each independently testable
5. **Maintainable**: Format changes only require .ksy updates
6. **Documented**: .ksy files serve as format documentation

## Limitations

1. **No Auto-Generated Writers**: Must implement separately
2. **Wrapper Overhead**: Extra layer between Kaitai and application
3. **Testing Complexity**: Must maintain cross-language test harness

## Future Enhancements

1. **Writer Code Generator**: Create tool to generate writers from .ksy
2. **Auto-Wrapper Generation**: Generate wrappers from .ksy metadata
3. **Performance Optimization**: Profile and optimize critical paths
4. **Format Validation**: Add runtime validation of parsed data
