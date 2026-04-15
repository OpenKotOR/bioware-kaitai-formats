meta:
  id: das
  title: 'BioWare DAS (Dragon Age: Origins Save) File Format'
  license: MIT
  endian: le
  file-extension: das
  xref:
    ghidra_odyssey_k1:
      note: "Dragon Age: Origins save format (daorigins.exe in Odyssey), not KotOR k1_win_gog_swkotor.exe."
    runtime: src/Andastra/Runtime/Games/Eclipse/DragonAgeOrigins/Save/DragonAgeOriginsSaveSerializer.cs
doc: |
  **DAS** (Dragon Age: Origins save): Eclipse binary save — `DAS ` signature, `version==1`, length-prefixed strings +
  tagged blocks. **Not KotOR** — Andastra serializer paths + numeric `xoreos_game_id` live in `meta.xref`.

doc-ref:
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L396-L408 xoreos — game id enum (Dragon Age = 7)"

seq:
  - id: signature
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File signature. Must be "DAS " for Dragon Age: Origins save files.
    valid:
      eq: '"DAS "'
  
  - id: version
    type: s4
    doc: |
      Save format version. Must be 1 for Dragon Age: Origins.
    valid: 1
  
  - id: save_name
    type: length_prefixed_string
    doc: User-entered save name displayed in UI
  
  - id: module_name
    type: length_prefixed_string
    doc: Current module resource name
  
  - id: area_name
    type: length_prefixed_string
    doc: Current area name for display
  
  - id: time_played_seconds
    type: s4
    doc: Total play time in seconds
  
  - id: timestamp_filetime
    type: s8
    doc: |
      Save creation timestamp as Windows FILETIME (int64).
      Convert using DateTime.FromFileTime().
  
  - id: num_screenshot_data
    type: s4
    doc: Length of screenshot data in bytes (0 if no screenshot)
  
  - id: screenshot_data
    type: u1
    repeat: expr
    repeat-expr: num_screenshot_data
    if: num_screenshot_data > 0
    doc: Screenshot image data (typically TGA or DDS format)
  
  - id: num_portrait_data
    type: s4
    doc: Length of portrait data in bytes (0 if no portrait)
  
  - id: portrait_data
    type: u1
    repeat: expr
    repeat-expr: num_portrait_data
    if: num_portrait_data > 0
    doc: Portrait image data (typically TGA or DDS format)
  
  - id: player_name
    type: length_prefixed_string
    doc: Player character name
  
  - id: party_member_count
    type: s4
    doc: Number of party members (from PartyState)
  
  - id: player_level
    type: s4
    doc: Player character level (from PartyState.PlayerCharacter)

types:
  length_prefixed_string:
    seq:
      - id: length
        type: s4
        doc: |
          String length in bytes (UTF-8 encoding).
          Must be >= 0 and <= 65536 (sanity check).
      
      - id: value
        type: str
        encoding: UTF-8
        size: length
        terminator: 0
        include: false
        doc: String value (UTF-8 encoded)
    instances:
      value_trimmed:
        value: value
        doc: |
          String value.
          Note: trailing null bytes are already excluded via `terminator: 0` and `include: false`.

