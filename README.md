# BioWare Kaitai Struct Formats

A comprehensive collection of [Kaitai Struct](https://kaitai.io/) format definitions for BioWare game engine file formats, enabling cross-language support for reading and writing binary files from KOTOR, Neverwinter Nights, Dragon Age, Mass Effect, and other BioWare games.

## Overview

This repository provides Kaitai Struct (`.ksy`) format definitions for all major BioWare engine file formats, allowing developers to work with these formats in any programming language supported by Kaitai Struct. Simply use your language's Kaitai Struct runtime to read and parse these binary file formats.

## Supported File Formats

### Core Formats

- **GFF** - Generic File Format (used by UTC, UTI, DLG, ARE, GIT, IFO, and many others)
- **ERF** - Encapsulated Resource Format (modules, DLCs)
- **BIF/KEY** - BioWare Index File / Key File (resource archives)
- **RIM** - Resource Information Module (module resources)
- **TPC** - Texture Package Container (textures)
- **MDL/MDX** - Model formats (3D models)
- **2DA** - Two-Dimensional Array (game data tables)
- **TLK** - Talk Table (dialogue strings)
- **NCS/NSS** - NWScript bytecode and source
- **WAV** - Audio format (with BioWare-specific extensions)
- **BWM** - BioWare Walkmesh (navigation meshes)
- **LYT/VIS** - Layout and Visibility (area layout)

### Game-Specific Formats

- **DLG** - Dialogue files
- **CNV** - Conversation files
- **UTC** - Creature templates
- **UTI** - Item definitions
- **ARE** - Area definitions
- **GIT** - Game Instance Template
- **IFO** - Module information
- **JRL** - Journal entries
- **LIP** - Lip-sync animation
- **PCC** - Package files (Mass Effect)
- **DA2S** - Dragon Age 2 saves
- And many more...

### Variant Formats

Many formats have XML and JSON variants used in modern tools:

- `*_XML.ksy` - XML serialization formats
- `*_JSON.ksy` - JSON serialization formats

## Supported Languages

Generated code lives under `src/<language>/kaitai_generated/`. **PyPI** carries stable Python wheels; other ecosystems are primarily **in-repo generators** (see `.github/workflows/*.yml` for optional publish steps — do not assume a registry URL exists until a release is published there).

- **Python** — [PyPI](https://pypi.org/project/bioware-kaitai-formats/)
- **JavaScript/TypeScript** — `src/javascript/` / `src/typescript/` (optional npm publish: `javascript.yml`)
- **Java** — `src/java/` (optional Maven Central: `java.yml`)
- **Go** — `src/go/` (module path from this repository)
- **Rust** — `src/rust/` (optional crates.io: `rust.yml`)
- **C/C++** — [vcpkg](https://github.com/microsoft/vcpkg) port overlay patterns; generated headers/sources under `src/cpp/`
- **C#** — `src/csharp/` (optional NuGet: `csharp.yml`)
- **Ruby** — `src/ruby/` (optional RubyGems: `ruby.yml`)
- **PHP** — [Packagist](https://packagist.org/packages/bioware/kaitai-formats) (when a tagged release is pushed)
- **Lua** — `src/lua/` (optional LuaRocks: `lua.yml`)
- **Perl** — [CPAN](https://metacpan.org/pod/BioWare::Kaitai::Formats) (when indexed)
- **Nim** — `src/nim/` (optional nimble directory listing)
- **Swift** — [Swift Package Manager](https://www.swift.org/documentation/package-manager/) (generated `src/swift/` layout)

## Quick Start

### Python Example

```python
import kaitaistruct
from bioware_kaitai_formats.gff import Gff

# Read a GFF file
with open('creature.utc', 'rb') as f:
    data = Gff.from_bytes(f.read())
    
    # Access the root struct
    root = data.root_struct
    print(f"Creature name: {root.get('FirstName')}")
```

### JavaScript Example

```javascript
const { Gff } = require('bioware-kaitai-formats');

// Read a GFF file
const fs = require('fs');
const data = fs.readFileSync('creature.utc');
const gff = new Gff(new KaitaiStream(data));

// Access the root struct
const root = gff.rootStruct;
console.log(`Creature name: ${root.firstName}`);
```

### Rust Example

```rust
use bioware_kaitai_formats::gff::Gff;
use std::fs::File;
use std::io::Read;

// Read a GFF file
let mut file = File::open("creature.utc")?;
let mut buffer = Vec::new();
file.read_to_end(&mut buffer)?;

let gff = Gff::from_bytes(&buffer)?;
let root = gff.root_struct();
println!("Creature name: {}", root.first_name()?);
```

## Installation

Install the package for your language:

```bash
# Python
pip install bioware-kaitai-formats

# Node.js
npm install bioware-kaitai-formats

# Java (Maven)
<dependency>
  <groupId>com.bioware</groupId>
  <artifactId>kaitai-formats</artifactId>
  <version>1.0.0</version>
</dependency>

# Go
go get github.com/yourorg/bioware-kaitai-formats

# Rust
cargo add bioware-kaitai-formats

# C# (.NET)
dotnet add package BioWareKaitaiFormats

# Ruby
gem install bioware-kaitai-formats
```

## Game Engine Support

These formats are used across multiple BioWare engine families:

- **Odyssey Engine**: Knights of the Old Republic (KOTOR), KOTOR II: The Sith Lords, Jade Empire
- **Aurora Engine**: Neverwinter Nights, Neverwinter Nights 2, Neverwinter Nights: Extended Edition
- **Eclipse Engine**: Dragon Age: Origins, Dragon Age II, Mass Effect, Mass Effect 2
- **Infinity Engine**: Baldur's Gate, Icewind Dale, Planescape: Torment (some formats)

## Repository Structure

```
formats/
├── BIF/          # BioWare Index Files
├── BWM/          # Walkmesh files
├── ERF/          # Encapsulated Resource Format
├── GFF/          # Generic File Format and variants
│   ├── Generics/ # Game-specific GFF types (UTC, UTI, DLG, etc.)
│   ├── JSON/     # JSON variants
│   └── XML/      # XML variants
├── MDL/          # Model files
├── NSS/          # NWScript formats
├── TPC/          # Texture formats
├── TLK/          # Talk table formats
└── ...           # Other formats
```

## Building from Source

### Requirements

- [Kaitai Struct Compiler](https://kaitai.io/#download) 0.11 or later

### Generate Code for Your Language

```bash
# Install Kaitai Struct compiler
pip install kaitai-struct-compiler

# Generate Python code
ksc -t python formats/GFF/GFF.ksy -d generated/python

# Generate JavaScript code
ksc -t javascript formats/GFF/GFF.ksy -d generated/javascript

# Generate Java code
ksc -t java formats/GFF/GFF.ksy -d generated/java

# Generate Rust code
ksc -t rust formats/GFF/GFF.ksy -d generated/rust
```

## CI/CD

This repository uses GitHub Actions to automatically:

1. Generate code for all supported languages using Kaitai Struct compiler
2. Run tests for generated code
3. Publish packages to respective package managers
4. Only commit and push when files change (detecting updates to format definitions or compiler versions)

Workflows run on:

- Push to main branch
- Pull requests
- Manual workflow dispatch

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Add or modify `.ksy` format definitions in `formats/`
3. Ensure definitions follow Kaitai Struct best practices
4. Test your changes with sample files from the games
5. Submit a pull request

## Documentation

Format definitions include inline documentation explaining:

- File structure and layout
- Field meanings and usage
- Game engine compatibility
- References to original documentation

## References

- [Kaitai Struct Documentation](https://doc.kaitai.io/)
- [PyKotor](https://github.com/OldRepublicDevs/PyKotor) - Python implementation reference
- [Andastra](https://github.com/OldRepublicDevs/Andastra) - C# implementation reference
- [Xoreos Main Website](https://xoreos.org/) - C/C++ implementation reference
- [Reone Project](https://github.com/seedhartha/reone) - Additional C/C++ references

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Format definitions are derived from reverse engineering and community documentation
- Inspired by implementations in PyKotor, Xoreos, and other open-source projects
- Special thanks to the BioWare modding community for format documentation
