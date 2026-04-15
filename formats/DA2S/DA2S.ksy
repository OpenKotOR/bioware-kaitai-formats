meta:
  id: da2s
  title: BioWare DA2S (Dragon Age 2 Save) File Format
  license: MIT
  endian: le
  file-extension: da2s
  xref:
    ghidra_odyssey_k1:
      note: "Dragon Age 2 save format (DragonAge2.exe in Odyssey), not KotOR k1_win_gog_swkotor.exe."
    runtime: src/Andastra/Runtime/Games/Eclipse/DragonAge2/Save/DragonAge2SaveSerializer.cs
doc: |
  **DA2S** (Dragon Age 2 save): Eclipse binary save — `DA2S` signature, `version==1`, length-prefixed strings + tagged
  blocks (party/inventory/journal/etc.). **Not KotOR** — see `meta.xref` for Andastra serializer paths + `xoreos_game_id`.

doc-ref:
  - "https://github.com/th3w1zard1/xoreos/blob/f36b681b2a38799ddd6fce0f252b6d7fa781dfc2/src/aurora/types.h#L396-L408 xoreos — game id enum (Dragon Age 2 = 8)"

seq:
  - id: signature
    type: str
    encoding: ASCII
    size: 4
    doc: |
      File signature. Must be "DA2S" for Dragon Age 2 save files.
    valid:
      eq: '"DA2S"'
  
  - id: version
    type: s4
    doc: |
      Save format version. Must be 1 for Dragon Age 2.
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

