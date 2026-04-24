<?php
// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

/**
 * BioWare MDL Model Format
 * 
 * The MDL file contains:
 * - File header (12 bytes)
 * - Model header (196 bytes) which begins with a Geometry header (80 bytes)
 * - Name offset array + name strings
 * - Animation offset array + animation headers + animation nodes
 * - Node hierarchy with geometry data
 * 
 * Authoritative cross-implementations: `meta.xref` (PyKotor `io_mdl` / `mdl_data`, xoreos `Model_KotOR::load`, reone `MdlMdxReader::load`, KotOR.js loaders) and `doc-ref`.
 * 
 * Unknown `model_header` fields marked `TODO: VERIFY` in `seq` docs: see `meta.xref.mdl_model_header_unknown_fields_policy`.
 * 
 * Shared wire enums: imported from `formats/Common/bioware_mdl_common.ksy` — `model_type` and `controller.type`
 * are field-bound to `model_classification` / `controller_type`. `node_type` is a bitmask (instances use `&`);
 * compare numeric values against `bioware_mdl_common::node_type_value` in docs / tooling, not as a Kaitai `enum:`.
 */

namespace {
    class Mdl extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root === null ? $this : $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_fileHeader = new \Mdl\FileHeader($this->_io, $this, $this->_root);
            $this->_m_modelHeader = new \Mdl\ModelHeader($this->_io, $this, $this->_root);
        }
        protected $_m_animationOffsets;

        /**
         * Animation header offsets (relative to data_start)
         */
        public function animationOffsets() {
            if ($this->_m_animationOffsets !== null)
                return $this->_m_animationOffsets;
            if ($this->modelHeader()->animationCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->dataStart() + $this->modelHeader()->offsetToAnimations());
                $this->_m_animationOffsets = [];
                $n = $this->modelHeader()->animationCount();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_animationOffsets[] = $this->_io->readU4le();
                }
                $this->_io->seek($_pos);
            }
            return $this->_m_animationOffsets;
        }
        protected $_m_animations;

        /**
         * Animation headers (via offset table). Each list element is `mdl_animation_entry`;
         * the parsed header is `element.header` (same wire layout as `animation_header`).
         */
        public function animations() {
            if ($this->_m_animations !== null)
                return $this->_m_animations;
            if ($this->modelHeader()->animationCount() > 0) {
                $this->_m_animations = [];
                $n = $this->modelHeader()->animationCount();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_animations[] = new \Mdl\MdlAnimationEntry($i, $this->_io, $this, $this->_root);
                }
            }
            return $this->_m_animations;
        }
        protected $_m_dataStart;

        /**
         * MDL "data start" offset. Most offsets in this file are relative to the start of the MDL data
         * section, which begins immediately after the 12-byte file header.
         */
        public function dataStart() {
            if ($this->_m_dataStart !== null)
                return $this->_m_dataStart;
            $this->_m_dataStart = 12;
            return $this->_m_dataStart;
        }
        protected $_m_nameOffsets;

        /**
         * Name string offsets (relative to data_start)
         */
        public function nameOffsets() {
            if ($this->_m_nameOffsets !== null)
                return $this->_m_nameOffsets;
            if ($this->modelHeader()->nameOffsetsCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->dataStart() + $this->modelHeader()->offsetToNameOffsets());
                $this->_m_nameOffsets = [];
                $n = $this->modelHeader()->nameOffsetsCount();
                for ($i = 0; $i < $n; $i++) {
                    $this->_m_nameOffsets[] = $this->_io->readU4le();
                }
                $this->_io->seek($_pos);
            }
            return $this->_m_nameOffsets;
        }
        protected $_m_namesData;

        /**
         * Name string blob (substream). This follows the name offset array and continues up to the animation offset array.
         * Parsed as null-terminated ASCII strings in `name_strings`.
         */
        public function namesData() {
            if ($this->_m_namesData !== null)
                return $this->_m_namesData;
            if ($this->modelHeader()->nameOffsetsCount() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek(($this->dataStart() + $this->modelHeader()->offsetToNameOffsets()) + 4 * $this->modelHeader()->nameOffsetsCount());
                $this->_m__raw_namesData = $this->_io->readBytes(($this->dataStart() + $this->modelHeader()->offsetToAnimations()) - (($this->dataStart() + $this->modelHeader()->offsetToNameOffsets()) + 4 * $this->modelHeader()->nameOffsetsCount()));
                $_io__raw_namesData = new \Kaitai\Struct\Stream($this->_m__raw_namesData);
                $this->_m_namesData = new \Mdl\NameStrings($_io__raw_namesData, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_namesData;
        }
        protected $_m_rootNode;
        public function rootNode() {
            if ($this->_m_rootNode !== null)
                return $this->_m_rootNode;
            if ($this->modelHeader()->geometry()->rootNodeOffset() > 0) {
                $_pos = $this->_io->pos();
                $this->_io->seek($this->dataStart() + $this->modelHeader()->geometry()->rootNodeOffset());
                $this->_m_rootNode = new \Mdl\Node($this->_io, $this, $this->_root);
                $this->_io->seek($_pos);
            }
            return $this->_m_rootNode;
        }
        protected $_m_fileHeader;
        protected $_m_modelHeader;
        protected $_m__raw_namesData;
        public function fileHeader() { return $this->_m_fileHeader; }
        public function modelHeader() { return $this->_m_modelHeader; }
        public function _raw_namesData() { return $this->_m__raw_namesData; }
    }
}

/**
 * AABB (Axis-Aligned Bounding Box) header (336 bytes KOTOR 1, 344 bytes KOTOR 2) - extends trimesh_header
 */

namespace Mdl {
    class AabbHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_trimeshBase = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            $this->_m_unknown = $this->_io->readU4le();
        }
        protected $_m_trimeshBase;
        protected $_m_unknown;

        /**
         * Standard trimesh header
         */
        public function trimeshBase() { return $this->_m_trimeshBase; }

        /**
         * Purpose unknown
         */
        public function unknown() { return $this->_m_unknown; }
    }
}

/**
 * Animation event (36 bytes)
 */

namespace Mdl {
    class AnimationEvent extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_activationTime = $this->_io->readF4le();
            $this->_m_eventName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
        }
        protected $_m_activationTime;
        protected $_m_eventName;

        /**
         * Time in seconds when event triggers during animation playback
         */
        public function activationTime() { return $this->_m_activationTime; }

        /**
         * Name of event (null-terminated string, e.g., "detonate")
         */
        public function eventName() { return $this->_m_eventName; }
    }
}

/**
 * Animation header (136 bytes = 80 byte geometry header + 56 byte animation header)
 */

namespace Mdl {
    class AnimationHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\MdlAnimationEntry $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_geoHeader = new \Mdl\GeometryHeader($this->_io, $this, $this->_root);
            $this->_m_animationLength = $this->_io->readF4le();
            $this->_m_transitionTime = $this->_io->readF4le();
            $this->_m_animationRoot = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_eventArrayOffset = $this->_io->readU4le();
            $this->_m_eventCount = $this->_io->readU4le();
            $this->_m_eventCountDuplicate = $this->_io->readU4le();
            $this->_m_unknown = $this->_io->readU4le();
        }
        protected $_m_geoHeader;
        protected $_m_animationLength;
        protected $_m_transitionTime;
        protected $_m_animationRoot;
        protected $_m_eventArrayOffset;
        protected $_m_eventCount;
        protected $_m_eventCountDuplicate;
        protected $_m_unknown;

        /**
         * Standard 80-byte geometry header (geometry_type = 0x01 for animation)
         */
        public function geoHeader() { return $this->_m_geoHeader; }

        /**
         * Duration of animation in seconds
         */
        public function animationLength() { return $this->_m_animationLength; }

        /**
         * Transition/blend time to this animation in seconds
         */
        public function transitionTime() { return $this->_m_transitionTime; }

        /**
         * Root node name for animation (null-terminated string)
         */
        public function animationRoot() { return $this->_m_animationRoot; }

        /**
         * Offset to animation events array
         */
        public function eventArrayOffset() { return $this->_m_eventArrayOffset; }

        /**
         * Number of animation events
         */
        public function eventCount() { return $this->_m_eventCount; }

        /**
         * Duplicate value of event count
         */
        public function eventCountDuplicate() { return $this->_m_eventCountDuplicate; }

        /**
         * Purpose unknown
         */
        public function unknown() { return $this->_m_unknown; }
    }
}

/**
 * Animmesh header (388 bytes KOTOR 1, 396 bytes KOTOR 2) - extends trimesh_header
 */

namespace Mdl {
    class AnimmeshHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_trimeshBase = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            $this->_m_unknown = $this->_io->readF4le();
            $this->_m_unknownArray = new \Mdl\ArrayDefinition($this->_io, $this, $this->_root);
            $this->_m_unknownFloats = [];
            $n = 9;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_unknownFloats[] = $this->_io->readF4le();
            }
        }
        protected $_m_trimeshBase;
        protected $_m_unknown;
        protected $_m_unknownArray;
        protected $_m_unknownFloats;

        /**
         * Standard trimesh header
         */
        public function trimeshBase() { return $this->_m_trimeshBase; }

        /**
         * Purpose unknown
         */
        public function unknown() { return $this->_m_unknown; }

        /**
         * Unknown array definition
         */
        public function unknownArray() { return $this->_m_unknownArray; }

        /**
         * Unknown float values
         */
        public function unknownFloats() { return $this->_m_unknownFloats; }
    }
}

/**
 * Array definition structure (offset, count, count duplicate)
 */

namespace Mdl {
    class ArrayDefinition extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_offset = $this->_io->readS4le();
            $this->_m_count = $this->_io->readU4le();
            $this->_m_countDuplicate = $this->_io->readU4le();
        }
        protected $_m_offset;
        protected $_m_count;
        protected $_m_countDuplicate;

        /**
         * Offset to array (relative to MDL data start, offset 12)
         */
        public function offset() { return $this->_m_offset; }

        /**
         * Number of used entries
         */
        public function count() { return $this->_m_count; }

        /**
         * Duplicate of count (allocated entries)
         */
        public function countDuplicate() { return $this->_m_countDuplicate; }
    }
}

/**
 * Controller structure (16 bytes) - defines animation data for a node property over time
 */

namespace Mdl {
    class Controller extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_type = $this->_io->readU4le();
            $this->_m_unknown = $this->_io->readU2le();
            $this->_m_rowCount = $this->_io->readU2le();
            $this->_m_timeIndex = $this->_io->readU2le();
            $this->_m_dataIndex = $this->_io->readU2le();
            $this->_m_columnCount = $this->_io->readU1();
            $this->_m_padding = [];
            $n = 3;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_padding[] = $this->_io->readU1();
            }
        }
        protected $_m_usesBezier;

        /**
         * True if controller uses Bezier interpolation
         */
        public function usesBezier() {
            if ($this->_m_usesBezier !== null)
                return $this->_m_usesBezier;
            $this->_m_usesBezier = ($this->columnCount() & 16) != 0;
            return $this->_m_usesBezier;
        }
        protected $_m_type;
        protected $_m_unknown;
        protected $_m_rowCount;
        protected $_m_timeIndex;
        protected $_m_dataIndex;
        protected $_m_columnCount;
        protected $_m_padding;

        /**
         * Controller type identifier. Controllers define animation data for node properties over time.
         * 
         * Common Node Controllers (used by all node types):
         * - 8: Position (3 floats: X, Y, Z translation)
         * - 20: Orientation (4 floats: quaternion W, X, Y, Z rotation)
         * - 36: Scale (3 floats: X, Y, Z scale factors)
         * 
         * Light Controllers (specific to light nodes):
         * - 76: Color (light color, 3 floats: R, G, B)
         * - 88: Radius (light radius, 1 float)
         * - 96: Shadow Radius (shadow casting radius, 1 float)
         * - 100: Vertical Displacement (vertical offset, 1 float)
         * - 140: Multiplier (light intensity multiplier, 1 float)
         * 
         * Emitter Controllers (specific to emitter nodes):
         * - 80: Alpha End (final alpha value, 1 float)
         * - 84: Alpha Start (initial alpha value, 1 float)
         * - 88: Birth Rate (particle spawn rate, 1 float)
         * - 92: Bounce Coefficient (particle bounce factor, 1 float)
         * - 96: Combine Time (particle combination timing, 1 float)
         * - 100: Drag (particle drag/resistance, 1 float)
         * - 104: FPS (frames per second, 1 float)
         * - 108: Frame End (ending frame number, 1 float)
         * - 112: Frame Start (starting frame number, 1 float)
         * - 116: Gravity (gravity force, 1 float)
         * - 120: Life Expectancy (particle lifetime, 1 float)
         * - 124: Mass (particle mass, 1 float)
         * - 128: P2P Bezier 2 (point-to-point bezier control point 2, varies)
         * - 132: P2P Bezier 3 (point-to-point bezier control point 3, varies)
         * - 136: Particle Rotation (particle rotation speed/angle, 1 float)
         * - 140: Random Velocity (random velocity component, 3 floats: X, Y, Z)
         * - 144: Size Start (initial particle size, 1 float)
         * - 148: Size End (final particle size, 1 float)
         * - 152: Size Start Y (initial particle size Y component, 1 float)
         * - 156: Size End Y (final particle size Y component, 1 float)
         * - 160: Spread (particle spread angle, 1 float)
         * - 164: Threshold (threshold value, 1 float)
         * - 168: Velocity (particle velocity, 3 floats: X, Y, Z)
         * - 172: X Size (particle X dimension size, 1 float)
         * - 176: Y Size (particle Y dimension size, 1 float)
         * - 180: Blur Length (motion blur length, 1 float)
         * - 184: Lightning Delay (lightning effect delay, 1 float)
         * - 188: Lightning Radius (lightning effect radius, 1 float)
         * - 192: Lightning Scale (lightning effect scale factor, 1 float)
         * - 196: Lightning Subdivide (lightning subdivision count, 1 float)
         * - 200: Lightning Zig Zag (lightning zigzag pattern, 1 float)
         * - 216: Alpha Mid (mid-point alpha value, 1 float)
         * - 220: Percent Start (starting percentage, 1 float)
         * - 224: Percent Mid (mid-point percentage, 1 float)
         * - 228: Percent End (ending percentage, 1 float)
         * - 232: Size Mid (mid-point particle size, 1 float)
         * - 236: Size Mid Y (mid-point particle size Y component, 1 float)
         * - 240: Random Birth Rate (randomized particle spawn rate, 1 float)
         * - 252: Target Size (target particle size, 1 float)
         * - 256: Number of Control Points (control point count, 1 float)
         * - 260: Control Point Radius (control point radius, 1 float)
         * - 264: Control Point Delay (control point delay timing, 1 float)
         * - 268: Tangent Spread (tangent spread angle, 1 float)
         * - 272: Tangent Length (tangent vector length, 1 float)
         * - 284: Color Mid (mid-point color, 3 floats: R, G, B)
         * - 380: Color End (final color, 3 floats: R, G, B)
         * - 392: Color Start (initial color, 3 floats: R, G, B)
         * - 502: Emitter Detonate (detonation trigger, 1 float)
         * 
         * Mesh Controllers (used by all mesh node types: trimesh, skinmesh, animmesh, danglymesh, AABB, lightsaber):
         * - 100: SelfIllumColor (self-illumination color, 3 floats: R, G, B)
         * - 128: Alpha (transparency/opacity, 1 float)
         * 
         * Reference: https://github.com/OpenKotOR/PyKotor/wiki/MDL-MDX-File-Format - Additional Controller Types section
         * Reference: https://github.com/OpenKotOR/MDLOps/blob/master/MDLOpsM.pm#L342-L407 — Controller type definitions
         * Reference: https://github.com/xoreos/xoreos-docs/blob/master/specs/torlack/binmdl.html - Comprehensive controller list
         */
        public function type() { return $this->_m_type; }

        /**
         * Purpose unknown, typically 0xFFFF
         */
        public function unknown() { return $this->_m_unknown; }

        /**
         * Number of keyframe rows (timepoints) for this controller
         */
        public function rowCount() { return $this->_m_rowCount; }

        /**
         * Index into controller data array where time values begin
         */
        public function timeIndex() { return $this->_m_timeIndex; }

        /**
         * Index into controller data array where property values begin
         */
        public function dataIndex() { return $this->_m_dataIndex; }

        /**
         * Number of float values per keyframe (e.g., 3 for position XYZ, 4 for quaternion WXYZ)
         * If bit 4 (0x10) is set, controller uses Bezier interpolation and stores 3× data per keyframe
         */
        public function columnCount() { return $this->_m_columnCount; }

        /**
         * Padding bytes for 16-byte alignment
         */
        public function padding() { return $this->_m_padding; }
    }
}

/**
 * Danglymesh header (360 bytes KOTOR 1, 368 bytes KOTOR 2) - extends trimesh_header
 */

namespace Mdl {
    class DanglymeshHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_trimeshBase = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            $this->_m_constraintsOffset = $this->_io->readU4le();
            $this->_m_constraintsCount = $this->_io->readU4le();
            $this->_m_constraintsCountDuplicate = $this->_io->readU4le();
            $this->_m_displacement = $this->_io->readF4le();
            $this->_m_tightness = $this->_io->readF4le();
            $this->_m_period = $this->_io->readF4le();
            $this->_m_unknown = $this->_io->readU4le();
        }
        protected $_m_trimeshBase;
        protected $_m_constraintsOffset;
        protected $_m_constraintsCount;
        protected $_m_constraintsCountDuplicate;
        protected $_m_displacement;
        protected $_m_tightness;
        protected $_m_period;
        protected $_m_unknown;

        /**
         * Standard trimesh header
         */
        public function trimeshBase() { return $this->_m_trimeshBase; }

        /**
         * Offset to vertex constraint values array
         */
        public function constraintsOffset() { return $this->_m_constraintsOffset; }

        /**
         * Number of vertex constraints (matches vertex count)
         */
        public function constraintsCount() { return $this->_m_constraintsCount; }

        /**
         * Duplicate of constraints count
         */
        public function constraintsCountDuplicate() { return $this->_m_constraintsCountDuplicate; }

        /**
         * Maximum displacement distance for physics simulation
         */
        public function displacement() { return $this->_m_displacement; }

        /**
         * Tightness/stiffness of spring simulation (0.0-1.0)
         */
        public function tightness() { return $this->_m_tightness; }

        /**
         * Oscillation period in seconds
         */
        public function period() { return $this->_m_period; }

        /**
         * Purpose unknown
         */
        public function unknown() { return $this->_m_unknown; }
    }
}

/**
 * Emitter header (224 bytes)
 */

namespace Mdl {
    class EmitterHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_deadSpace = $this->_io->readF4le();
            $this->_m_blastRadius = $this->_io->readF4le();
            $this->_m_blastLength = $this->_io->readF4le();
            $this->_m_branchCount = $this->_io->readU4le();
            $this->_m_controlPointSmoothing = $this->_io->readF4le();
            $this->_m_xGrid = $this->_io->readU4le();
            $this->_m_yGrid = $this->_io->readU4le();
            $this->_m_paddingUnknown = $this->_io->readU4le();
            $this->_m_updateScript = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_renderScript = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_blendScript = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_textureName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_chunkName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_twoSidedTexture = $this->_io->readU4le();
            $this->_m_loop = $this->_io->readU4le();
            $this->_m_renderOrder = $this->_io->readU2le();
            $this->_m_frameBlending = $this->_io->readU1();
            $this->_m_depthTextureName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_padding = $this->_io->readU1();
            $this->_m_flags = $this->_io->readU4le();
        }
        protected $_m_deadSpace;
        protected $_m_blastRadius;
        protected $_m_blastLength;
        protected $_m_branchCount;
        protected $_m_controlPointSmoothing;
        protected $_m_xGrid;
        protected $_m_yGrid;
        protected $_m_paddingUnknown;
        protected $_m_updateScript;
        protected $_m_renderScript;
        protected $_m_blendScript;
        protected $_m_textureName;
        protected $_m_chunkName;
        protected $_m_twoSidedTexture;
        protected $_m_loop;
        protected $_m_renderOrder;
        protected $_m_frameBlending;
        protected $_m_depthTextureName;
        protected $_m_padding;
        protected $_m_flags;

        /**
         * Minimum distance from emitter before particles become visible
         */
        public function deadSpace() { return $this->_m_deadSpace; }

        /**
         * Radius of explosive/blast particle effects
         */
        public function blastRadius() { return $this->_m_blastRadius; }

        /**
         * Length/duration of blast effects
         */
        public function blastLength() { return $this->_m_blastLength; }

        /**
         * Number of branching paths for particle trails
         */
        public function branchCount() { return $this->_m_branchCount; }

        /**
         * Smoothing factor for particle path control points
         */
        public function controlPointSmoothing() { return $this->_m_controlPointSmoothing; }

        /**
         * Grid subdivisions along X axis for particle spawning
         */
        public function xGrid() { return $this->_m_xGrid; }

        /**
         * Grid subdivisions along Y axis for particle spawning
         */
        public function yGrid() { return $this->_m_yGrid; }

        /**
         * Purpose unknown or padding
         */
        public function paddingUnknown() { return $this->_m_paddingUnknown; }

        /**
         * Update behavior script name (e.g., "single", "fountain")
         */
        public function updateScript() { return $this->_m_updateScript; }

        /**
         * Render mode script name (e.g., "normal", "billboard_to_local_z")
         */
        public function renderScript() { return $this->_m_renderScript; }

        /**
         * Blend mode script name (e.g., "normal", "lighten")
         */
        public function blendScript() { return $this->_m_blendScript; }

        /**
         * Particle texture name (null-terminated string)
         */
        public function textureName() { return $this->_m_textureName; }

        /**
         * Associated model chunk name (null-terminated string)
         */
        public function chunkName() { return $this->_m_chunkName; }

        /**
         * 1 if texture should render two-sided, 0 for single-sided
         */
        public function twoSidedTexture() { return $this->_m_twoSidedTexture; }

        /**
         * 1 if particle system loops, 0 for single playback
         */
        public function loop() { return $this->_m_loop; }

        /**
         * Rendering priority/order for particle sorting
         */
        public function renderOrder() { return $this->_m_renderOrder; }

        /**
         * 1 if frame blending enabled, 0 otherwise
         */
        public function frameBlending() { return $this->_m_frameBlending; }

        /**
         * Depth/softparticle texture name (null-terminated string)
         */
        public function depthTextureName() { return $this->_m_depthTextureName; }

        /**
         * Padding byte for alignment
         */
        public function padding() { return $this->_m_padding; }

        /**
         * Emitter behavior flags bitmask (P2P, bounce, inherit, etc.)
         */
        public function flags() { return $this->_m_flags; }
    }
}

/**
 * MDL file header (12 bytes)
 */

namespace Mdl {
    class FileHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_unused = $this->_io->readU4le();
            $this->_m_mdlSize = $this->_io->readU4le();
            $this->_m_mdxSize = $this->_io->readU4le();
        }
        protected $_m_unused;
        protected $_m_mdlSize;
        protected $_m_mdxSize;

        /**
         * Always 0
         */
        public function unused() { return $this->_m_unused; }

        /**
         * Size of MDL file in bytes
         */
        public function mdlSize() { return $this->_m_mdlSize; }

        /**
         * Size of MDX file in bytes
         */
        public function mdxSize() { return $this->_m_mdxSize; }
    }
}

/**
 * Geometry header is 80 (0x50) bytes long, located at offset 12 (0xC)
 */

namespace Mdl {
    class GeometryHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_functionPointer0 = $this->_io->readU4le();
            $this->_m_functionPointer1 = $this->_io->readU4le();
            $this->_m_modelName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_rootNodeOffset = $this->_io->readU4le();
            $this->_m_nodeCount = $this->_io->readU4le();
            $this->_m_unknownArray1 = new \Mdl\ArrayDefinition($this->_io, $this, $this->_root);
            $this->_m_unknownArray2 = new \Mdl\ArrayDefinition($this->_io, $this, $this->_root);
            $this->_m_referenceCount = $this->_io->readU4le();
            $this->_m_geometryType = $this->_io->readU1();
            $this->_m_padding = [];
            $n = 3;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_padding[] = $this->_io->readU1();
            }
        }
        protected $_m_isKotor2;

        /**
         * True if this is a KOTOR 2 model
         */
        public function isKotor2() {
            if ($this->_m_isKotor2 !== null)
                return $this->_m_isKotor2;
            $this->_m_isKotor2 =  (($this->functionPointer0() == 4285200) || ($this->functionPointer0() == 4285872)) ;
            return $this->_m_isKotor2;
        }
        protected $_m_functionPointer0;
        protected $_m_functionPointer1;
        protected $_m_modelName;
        protected $_m_rootNodeOffset;
        protected $_m_nodeCount;
        protected $_m_unknownArray1;
        protected $_m_unknownArray2;
        protected $_m_referenceCount;
        protected $_m_geometryType;
        protected $_m_padding;

        /**
         * Game engine version identifier:
         * - KOTOR 1 PC: 4273776 (0x413670)
         * - KOTOR 2 PC: 4285200 (0x416310)
         * - KOTOR 1 Xbox: 4254992 (0x40ED10)
         * - KOTOR 2 Xbox: 4285872 (0x4165B0)
         */
        public function functionPointer0() { return $this->_m_functionPointer0; }

        /**
         * Function pointer to ASCII model parser
         */
        public function functionPointer1() { return $this->_m_functionPointer1; }

        /**
         * Model name, null-terminated string, max 32 (0x20) bytes
         */
        public function modelName() { return $this->_m_modelName; }

        /**
         * Offset to root node structure, relative to MDL data start, offset 12 (0xC) bytes
         */
        public function rootNodeOffset() { return $this->_m_rootNodeOffset; }

        /**
         * Total number of nodes in model hierarchy, unsigned 32-bit integer
         */
        public function nodeCount() { return $this->_m_nodeCount; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        public function unknownArray1() { return $this->_m_unknownArray1; }

        /**
         * Unknown array definition (offset, count, count duplicate)
         */
        public function unknownArray2() { return $this->_m_unknownArray2; }

        /**
         * Reference count (initialized to 0, incremented when model is referenced)
         */
        public function referenceCount() { return $this->_m_referenceCount; }

        /**
         * Geometry type:
         * - 0x01: Basic geometry header (not in models)
         * - 0x02: Model geometry header
         * - 0x05: Animation geometry header
         * If bit 7 (0x80) is set, model is compiled binary with absolute addresses
         */
        public function geometryType() { return $this->_m_geometryType; }

        /**
         * Padding bytes for alignment
         */
        public function padding() { return $this->_m_padding; }
    }
}

/**
 * Light header (92 bytes)
 */

namespace Mdl {
    class LightHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_unknown = [];
            $n = 4;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_unknown[] = $this->_io->readF4le();
            }
            $this->_m_flareSizesOffset = $this->_io->readU4le();
            $this->_m_flareSizesCount = $this->_io->readU4le();
            $this->_m_flareSizesCountDuplicate = $this->_io->readU4le();
            $this->_m_flarePositionsOffset = $this->_io->readU4le();
            $this->_m_flarePositionsCount = $this->_io->readU4le();
            $this->_m_flarePositionsCountDuplicate = $this->_io->readU4le();
            $this->_m_flareColorShiftsOffset = $this->_io->readU4le();
            $this->_m_flareColorShiftsCount = $this->_io->readU4le();
            $this->_m_flareColorShiftsCountDuplicate = $this->_io->readU4le();
            $this->_m_flareTextureNamesOffset = $this->_io->readU4le();
            $this->_m_flareTextureNamesCount = $this->_io->readU4le();
            $this->_m_flareTextureNamesCountDuplicate = $this->_io->readU4le();
            $this->_m_flareRadius = $this->_io->readF4le();
            $this->_m_lightPriority = $this->_io->readU4le();
            $this->_m_ambientOnly = $this->_io->readU4le();
            $this->_m_dynamicType = $this->_io->readU4le();
            $this->_m_affectDynamic = $this->_io->readU4le();
            $this->_m_shadow = $this->_io->readU4le();
            $this->_m_flare = $this->_io->readU4le();
            $this->_m_fadingLight = $this->_io->readU4le();
        }
        protected $_m_unknown;
        protected $_m_flareSizesOffset;
        protected $_m_flareSizesCount;
        protected $_m_flareSizesCountDuplicate;
        protected $_m_flarePositionsOffset;
        protected $_m_flarePositionsCount;
        protected $_m_flarePositionsCountDuplicate;
        protected $_m_flareColorShiftsOffset;
        protected $_m_flareColorShiftsCount;
        protected $_m_flareColorShiftsCountDuplicate;
        protected $_m_flareTextureNamesOffset;
        protected $_m_flareTextureNamesCount;
        protected $_m_flareTextureNamesCountDuplicate;
        protected $_m_flareRadius;
        protected $_m_lightPriority;
        protected $_m_ambientOnly;
        protected $_m_dynamicType;
        protected $_m_affectDynamic;
        protected $_m_shadow;
        protected $_m_flare;
        protected $_m_fadingLight;

        /**
         * Purpose unknown, possibly padding or reserved values
         */
        public function unknown() { return $this->_m_unknown; }

        /**
         * Offset to flare sizes array (floats)
         */
        public function flareSizesOffset() { return $this->_m_flareSizesOffset; }

        /**
         * Number of flare size entries
         */
        public function flareSizesCount() { return $this->_m_flareSizesCount; }

        /**
         * Duplicate of flare sizes count
         */
        public function flareSizesCountDuplicate() { return $this->_m_flareSizesCountDuplicate; }

        /**
         * Offset to flare positions array (floats, 0.0-1.0 along light ray)
         */
        public function flarePositionsOffset() { return $this->_m_flarePositionsOffset; }

        /**
         * Number of flare position entries
         */
        public function flarePositionsCount() { return $this->_m_flarePositionsCount; }

        /**
         * Duplicate of flare positions count
         */
        public function flarePositionsCountDuplicate() { return $this->_m_flarePositionsCountDuplicate; }

        /**
         * Offset to flare color shift array (RGB floats)
         */
        public function flareColorShiftsOffset() { return $this->_m_flareColorShiftsOffset; }

        /**
         * Number of flare color shift entries
         */
        public function flareColorShiftsCount() { return $this->_m_flareColorShiftsCount; }

        /**
         * Duplicate of flare color shifts count
         */
        public function flareColorShiftsCountDuplicate() { return $this->_m_flareColorShiftsCountDuplicate; }

        /**
         * Offset to flare texture name string offsets array
         */
        public function flareTextureNamesOffset() { return $this->_m_flareTextureNamesOffset; }

        /**
         * Number of flare texture names
         */
        public function flareTextureNamesCount() { return $this->_m_flareTextureNamesCount; }

        /**
         * Duplicate of flare texture names count
         */
        public function flareTextureNamesCountDuplicate() { return $this->_m_flareTextureNamesCountDuplicate; }

        /**
         * Radius of flare effect
         */
        public function flareRadius() { return $this->_m_flareRadius; }

        /**
         * Rendering priority for light culling/sorting
         */
        public function lightPriority() { return $this->_m_lightPriority; }

        /**
         * 1 if light only affects ambient, 0 for full lighting
         */
        public function ambientOnly() { return $this->_m_ambientOnly; }

        /**
         * Type of dynamic lighting behavior
         */
        public function dynamicType() { return $this->_m_dynamicType; }

        /**
         * 1 if light affects dynamic objects, 0 otherwise
         */
        public function affectDynamic() { return $this->_m_affectDynamic; }

        /**
         * 1 if light casts shadows, 0 otherwise
         */
        public function shadow() { return $this->_m_shadow; }

        /**
         * 1 if lens flare effect enabled, 0 otherwise
         */
        public function flare() { return $this->_m_flare; }

        /**
         * 1 if light intensity fades with distance, 0 otherwise
         */
        public function fadingLight() { return $this->_m_fadingLight; }
    }
}

/**
 * Lightsaber header (352 bytes KOTOR 1, 360 bytes KOTOR 2) - extends trimesh_header
 */

namespace Mdl {
    class LightsaberHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_trimeshBase = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            $this->_m_verticesOffset = $this->_io->readU4le();
            $this->_m_texcoordsOffset = $this->_io->readU4le();
            $this->_m_normalsOffset = $this->_io->readU4le();
            $this->_m_unknown1 = $this->_io->readU4le();
            $this->_m_unknown2 = $this->_io->readU4le();
        }
        protected $_m_trimeshBase;
        protected $_m_verticesOffset;
        protected $_m_texcoordsOffset;
        protected $_m_normalsOffset;
        protected $_m_unknown1;
        protected $_m_unknown2;

        /**
         * Standard trimesh header
         */
        public function trimeshBase() { return $this->_m_trimeshBase; }

        /**
         * Offset to vertex position array in MDL file (3 floats × 8 vertices × 20 pieces)
         */
        public function verticesOffset() { return $this->_m_verticesOffset; }

        /**
         * Offset to texture coordinates array in MDL file (2 floats × 8 vertices × 20)
         */
        public function texcoordsOffset() { return $this->_m_texcoordsOffset; }

        /**
         * Offset to vertex normals array in MDL file (3 floats × 8 vertices × 20)
         */
        public function normalsOffset() { return $this->_m_normalsOffset; }

        /**
         * Purpose unknown
         */
        public function unknown1() { return $this->_m_unknown1; }

        /**
         * Purpose unknown
         */
        public function unknown2() { return $this->_m_unknown2; }
    }
}

/**
 * One animation slot: reads `animation_header` at `data_start + animation_offsets[anim_index]`.
 * Wraps the header so repeated root instances can use parametric types (user guide).
 */

namespace Mdl {
    class MdlAnimationEntry extends \Kaitai\Struct\Struct {
        public function __construct(int $animIndex, \Kaitai\Struct\Stream $_io, ?\Mdl $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_m_animIndex = $animIndex;
            $this->_read();
        }

        private function _read() {
        }
        protected $_m_header;
        public function header() {
            if ($this->_m_header !== null)
                return $this->_m_header;
            $_pos = $this->_io->pos();
            $this->_io->seek($this->_root()->dataStart() + $this->_root()->animationOffsets()[$this->animIndex()]);
            $this->_m_header = new \Mdl\AnimationHeader($this->_io, $this, $this->_root);
            $this->_io->seek($_pos);
            return $this->_m_header;
        }
        protected $_m_animIndex;
        public function animIndex() { return $this->_m_animIndex; }
    }
}

/**
 * Model header (196 bytes) starting at offset 12 (data_start).
 * This matches MDLOps / PyKotor's _ModelHeader layout: a geometry header followed by
 * model-wide metadata, offsets, and counts.
 */

namespace Mdl {
    class ModelHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_geometry = new \Mdl\GeometryHeader($this->_io, $this, $this->_root);
            $this->_m_modelType = $this->_io->readU1();
            $this->_m_unknown0 = $this->_io->readU1();
            $this->_m_padding0 = $this->_io->readU1();
            $this->_m_fog = $this->_io->readU1();
            $this->_m_unknown1 = $this->_io->readU4le();
            $this->_m_offsetToAnimations = $this->_io->readU4le();
            $this->_m_animationCount = $this->_io->readU4le();
            $this->_m_animationCount2 = $this->_io->readU4le();
            $this->_m_unknown2 = $this->_io->readU4le();
            $this->_m_boundingBoxMin = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_boundingBoxMax = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_radius = $this->_io->readF4le();
            $this->_m_animationScale = $this->_io->readF4le();
            $this->_m_supermodelName = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_offsetToSuperRoot = $this->_io->readU4le();
            $this->_m_unknown3 = $this->_io->readU4le();
            $this->_m_mdxDataSize = $this->_io->readU4le();
            $this->_m_mdxDataOffset = $this->_io->readU4le();
            $this->_m_offsetToNameOffsets = $this->_io->readU4le();
            $this->_m_nameOffsetsCount = $this->_io->readU4le();
            $this->_m_nameOffsetsCount2 = $this->_io->readU4le();
        }
        protected $_m_geometry;
        protected $_m_modelType;
        protected $_m_unknown0;
        protected $_m_padding0;
        protected $_m_fog;
        protected $_m_unknown1;
        protected $_m_offsetToAnimations;
        protected $_m_animationCount;
        protected $_m_animationCount2;
        protected $_m_unknown2;
        protected $_m_boundingBoxMin;
        protected $_m_boundingBoxMax;
        protected $_m_radius;
        protected $_m_animationScale;
        protected $_m_supermodelName;
        protected $_m_offsetToSuperRoot;
        protected $_m_unknown3;
        protected $_m_mdxDataSize;
        protected $_m_mdxDataOffset;
        protected $_m_offsetToNameOffsets;
        protected $_m_nameOffsetsCount;
        protected $_m_nameOffsetsCount2;

        /**
         * Geometry header (80 bytes)
         */
        public function geometry() { return $this->_m_geometry; }

        /**
         * Model classification byte
         */
        public function modelType() { return $this->_m_modelType; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public function unknown0() { return $this->_m_unknown0; }

        /**
         * Padding byte
         */
        public function padding0() { return $this->_m_padding0; }

        /**
         * Fog interaction (1 = affected, 0 = ignore fog)
         */
        public function fog() { return $this->_m_fog; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public function unknown1() { return $this->_m_unknown1; }

        /**
         * Offset to animation offset array (relative to data_start)
         */
        public function offsetToAnimations() { return $this->_m_offsetToAnimations; }

        /**
         * Number of animations
         */
        public function animationCount() { return $this->_m_animationCount; }

        /**
         * Duplicate animation count / allocated count
         */
        public function animationCount2() { return $this->_m_animationCount2; }

        /**
         * TODO: VERIFY - unknown field (MDLOps / PyKotor preserve)
         */
        public function unknown2() { return $this->_m_unknown2; }

        /**
         * Minimum coordinates of bounding box (X, Y, Z)
         */
        public function boundingBoxMin() { return $this->_m_boundingBoxMin; }

        /**
         * Maximum coordinates of bounding box (X, Y, Z)
         */
        public function boundingBoxMax() { return $this->_m_boundingBoxMax; }

        /**
         * Radius of model's bounding sphere
         */
        public function radius() { return $this->_m_radius; }

        /**
         * Scale factor for animations (typically 1.0)
         */
        public function animationScale() { return $this->_m_animationScale; }

        /**
         * Name of supermodel (null-terminated string, "null" if empty)
         */
        public function supermodelName() { return $this->_m_supermodelName; }

        /**
         * TODO: VERIFY - offset to super-root node (relative to data_start)
         */
        public function offsetToSuperRoot() { return $this->_m_offsetToSuperRoot; }

        /**
         * TODO: VERIFY - unknown field after offset_to_super_root (MDLOps / PyKotor preserve)
         */
        public function unknown3() { return $this->_m_unknown3; }

        /**
         * Size of MDX file data in bytes
         */
        public function mdxDataSize() { return $this->_m_mdxDataSize; }

        /**
         * Offset to MDX data (typically 0)
         */
        public function mdxDataOffset() { return $this->_m_mdxDataOffset; }

        /**
         * Offset to name offset array (relative to data_start)
         */
        public function offsetToNameOffsets() { return $this->_m_offsetToNameOffsets; }

        /**
         * Count of name offsets / partnames
         */
        public function nameOffsetsCount() { return $this->_m_nameOffsetsCount; }

        /**
         * Duplicate name offsets count / allocated count
         */
        public function nameOffsetsCount2() { return $this->_m_nameOffsetsCount2; }
    }
}

/**
 * Array of null-terminated name strings
 */

namespace Mdl {
    class NameStrings extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_strings = [];
            $i = 0;
            while (!$this->_io->isEof()) {
                $this->_m_strings[] = \Kaitai\Struct\Stream::bytesToStr($this->_io->readBytesTerm(0, false, true, true), "ASCII");
                $i++;
            }
        }
        protected $_m_strings;
        public function strings() { return $this->_m_strings; }
    }
}

/**
 * Node structure - starts with 80-byte header, followed by type-specific sub-header
 */

namespace Mdl {
    class Node extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_header = new \Mdl\NodeHeader($this->_io, $this, $this->_root);
            if ($this->header()->nodeType() == 3) {
                $this->_m_lightSubHeader = new \Mdl\LightHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 5) {
                $this->_m_emitterSubHeader = new \Mdl\EmitterHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 17) {
                $this->_m_referenceSubHeader = new \Mdl\ReferenceHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 33) {
                $this->_m_trimeshSubHeader = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 97) {
                $this->_m_skinmeshSubHeader = new \Mdl\SkinmeshHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 161) {
                $this->_m_animmeshSubHeader = new \Mdl\AnimmeshHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 289) {
                $this->_m_danglymeshSubHeader = new \Mdl\DanglymeshHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 545) {
                $this->_m_aabbSubHeader = new \Mdl\AabbHeader($this->_io, $this, $this->_root);
            }
            if ($this->header()->nodeType() == 2081) {
                $this->_m_lightsaberSubHeader = new \Mdl\LightsaberHeader($this->_io, $this, $this->_root);
            }
        }
        protected $_m_header;
        protected $_m_lightSubHeader;
        protected $_m_emitterSubHeader;
        protected $_m_referenceSubHeader;
        protected $_m_trimeshSubHeader;
        protected $_m_skinmeshSubHeader;
        protected $_m_animmeshSubHeader;
        protected $_m_danglymeshSubHeader;
        protected $_m_aabbSubHeader;
        protected $_m_lightsaberSubHeader;
        public function header() { return $this->_m_header; }
        public function lightSubHeader() { return $this->_m_lightSubHeader; }
        public function emitterSubHeader() { return $this->_m_emitterSubHeader; }
        public function referenceSubHeader() { return $this->_m_referenceSubHeader; }
        public function trimeshSubHeader() { return $this->_m_trimeshSubHeader; }
        public function skinmeshSubHeader() { return $this->_m_skinmeshSubHeader; }
        public function animmeshSubHeader() { return $this->_m_animmeshSubHeader; }
        public function danglymeshSubHeader() { return $this->_m_danglymeshSubHeader; }
        public function aabbSubHeader() { return $this->_m_aabbSubHeader; }
        public function lightsaberSubHeader() { return $this->_m_lightsaberSubHeader; }
    }
}

/**
 * Node header (80 bytes) - present in all node types
 */

namespace Mdl {
    class NodeHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_nodeType = $this->_io->readU2le();
            $this->_m_nodeIndex = $this->_io->readU2le();
            $this->_m_nodeNameIndex = $this->_io->readU2le();
            $this->_m_padding = $this->_io->readU2le();
            $this->_m_rootNodeOffset = $this->_io->readU4le();
            $this->_m_parentNodeOffset = $this->_io->readU4le();
            $this->_m_position = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_orientation = new \Mdl\Quaternion($this->_io, $this, $this->_root);
            $this->_m_childArrayOffset = $this->_io->readU4le();
            $this->_m_childCount = $this->_io->readU4le();
            $this->_m_childCountDuplicate = $this->_io->readU4le();
            $this->_m_controllerArrayOffset = $this->_io->readU4le();
            $this->_m_controllerCount = $this->_io->readU4le();
            $this->_m_controllerCountDuplicate = $this->_io->readU4le();
            $this->_m_controllerDataOffset = $this->_io->readU4le();
            $this->_m_controllerDataCount = $this->_io->readU4le();
            $this->_m_controllerDataCountDuplicate = $this->_io->readU4le();
        }
        protected $_m_hasAabb;
        public function hasAabb() {
            if ($this->_m_hasAabb !== null)
                return $this->_m_hasAabb;
            $this->_m_hasAabb = ($this->nodeType() & 512) != 0;
            return $this->_m_hasAabb;
        }
        protected $_m_hasAnim;
        public function hasAnim() {
            if ($this->_m_hasAnim !== null)
                return $this->_m_hasAnim;
            $this->_m_hasAnim = ($this->nodeType() & 128) != 0;
            return $this->_m_hasAnim;
        }
        protected $_m_hasDangly;
        public function hasDangly() {
            if ($this->_m_hasDangly !== null)
                return $this->_m_hasDangly;
            $this->_m_hasDangly = ($this->nodeType() & 256) != 0;
            return $this->_m_hasDangly;
        }
        protected $_m_hasEmitter;
        public function hasEmitter() {
            if ($this->_m_hasEmitter !== null)
                return $this->_m_hasEmitter;
            $this->_m_hasEmitter = ($this->nodeType() & 4) != 0;
            return $this->_m_hasEmitter;
        }
        protected $_m_hasLight;
        public function hasLight() {
            if ($this->_m_hasLight !== null)
                return $this->_m_hasLight;
            $this->_m_hasLight = ($this->nodeType() & 2) != 0;
            return $this->_m_hasLight;
        }
        protected $_m_hasMesh;
        public function hasMesh() {
            if ($this->_m_hasMesh !== null)
                return $this->_m_hasMesh;
            $this->_m_hasMesh = ($this->nodeType() & 32) != 0;
            return $this->_m_hasMesh;
        }
        protected $_m_hasReference;
        public function hasReference() {
            if ($this->_m_hasReference !== null)
                return $this->_m_hasReference;
            $this->_m_hasReference = ($this->nodeType() & 16) != 0;
            return $this->_m_hasReference;
        }
        protected $_m_hasSaber;
        public function hasSaber() {
            if ($this->_m_hasSaber !== null)
                return $this->_m_hasSaber;
            $this->_m_hasSaber = ($this->nodeType() & 2048) != 0;
            return $this->_m_hasSaber;
        }
        protected $_m_hasSkin;
        public function hasSkin() {
            if ($this->_m_hasSkin !== null)
                return $this->_m_hasSkin;
            $this->_m_hasSkin = ($this->nodeType() & 64) != 0;
            return $this->_m_hasSkin;
        }
        protected $_m_nodeType;
        protected $_m_nodeIndex;
        protected $_m_nodeNameIndex;
        protected $_m_padding;
        protected $_m_rootNodeOffset;
        protected $_m_parentNodeOffset;
        protected $_m_position;
        protected $_m_orientation;
        protected $_m_childArrayOffset;
        protected $_m_childCount;
        protected $_m_childCountDuplicate;
        protected $_m_controllerArrayOffset;
        protected $_m_controllerCount;
        protected $_m_controllerCountDuplicate;
        protected $_m_controllerDataOffset;
        protected $_m_controllerDataCount;
        protected $_m_controllerDataCountDuplicate;

        /**
         * Bitmask indicating node features (also carries the primary node kind in the composite values listed in
         * `bioware_mdl_common::node_type_value`; do not attach `enum:` here — instances below use bitwise `&` tests).
         * - 0x0001: NODE_HAS_HEADER
         * - 0x0002: NODE_HAS_LIGHT
         * - 0x0004: NODE_HAS_EMITTER
         * - 0x0008: NODE_HAS_CAMERA
         * - 0x0010: NODE_HAS_REFERENCE
         * - 0x0020: NODE_HAS_MESH
         * - 0x0040: NODE_HAS_SKIN
         * - 0x0080: NODE_HAS_ANIM
         * - 0x0100: NODE_HAS_DANGLY
         * - 0x0200: NODE_HAS_AABB
         * - 0x0800: NODE_HAS_SABER
         */
        public function nodeType() { return $this->_m_nodeType; }

        /**
         * Sequential index of this node in the model
         */
        public function nodeIndex() { return $this->_m_nodeIndex; }

        /**
         * Index into names array for this node's name
         */
        public function nodeNameIndex() { return $this->_m_nodeNameIndex; }

        /**
         * Padding for alignment
         */
        public function padding() { return $this->_m_padding; }

        /**
         * Offset to model's root node
         */
        public function rootNodeOffset() { return $this->_m_rootNodeOffset; }

        /**
         * Offset to this node's parent node (0 if root)
         */
        public function parentNodeOffset() { return $this->_m_parentNodeOffset; }

        /**
         * Node position in local space (X, Y, Z)
         */
        public function position() { return $this->_m_position; }

        /**
         * Node orientation as quaternion (W, X, Y, Z)
         */
        public function orientation() { return $this->_m_orientation; }

        /**
         * Offset to array of child node offsets
         */
        public function childArrayOffset() { return $this->_m_childArrayOffset; }

        /**
         * Number of child nodes
         */
        public function childCount() { return $this->_m_childCount; }

        /**
         * Duplicate value of child count
         */
        public function childCountDuplicate() { return $this->_m_childCountDuplicate; }

        /**
         * Offset to array of controller structures
         */
        public function controllerArrayOffset() { return $this->_m_controllerArrayOffset; }

        /**
         * Number of controllers attached to this node
         */
        public function controllerCount() { return $this->_m_controllerCount; }

        /**
         * Duplicate value of controller count
         */
        public function controllerCountDuplicate() { return $this->_m_controllerCountDuplicate; }

        /**
         * Offset to controller keyframe/data array
         */
        public function controllerDataOffset() { return $this->_m_controllerDataOffset; }

        /**
         * Number of floats in controller data array
         */
        public function controllerDataCount() { return $this->_m_controllerDataCount; }

        /**
         * Duplicate value of controller data count
         */
        public function controllerDataCountDuplicate() { return $this->_m_controllerDataCountDuplicate; }
    }
}

/**
 * Quaternion rotation (4 floats W, X, Y, Z)
 */

namespace Mdl {
    class Quaternion extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\NodeHeader $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_w = $this->_io->readF4le();
            $this->_m_x = $this->_io->readF4le();
            $this->_m_y = $this->_io->readF4le();
            $this->_m_z = $this->_io->readF4le();
        }
        protected $_m_w;
        protected $_m_x;
        protected $_m_y;
        protected $_m_z;
        public function w() { return $this->_m_w; }
        public function x() { return $this->_m_x; }
        public function y() { return $this->_m_y; }
        public function z() { return $this->_m_z; }
    }
}

/**
 * Reference header (36 bytes)
 */

namespace Mdl {
    class ReferenceHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_modelResref = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_reattachable = $this->_io->readU4le();
        }
        protected $_m_modelResref;
        protected $_m_reattachable;

        /**
         * Referenced model resource name without extension (null-terminated string)
         */
        public function modelResref() { return $this->_m_modelResref; }

        /**
         * 1 if model can be detached and reattached dynamically, 0 if permanent
         */
        public function reattachable() { return $this->_m_reattachable; }
    }
}

/**
 * Skinmesh header (432 bytes KOTOR 1, 440 bytes KOTOR 2) - extends trimesh_header
 */

namespace Mdl {
    class SkinmeshHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Mdl\Node $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_trimeshBase = new \Mdl\TrimeshHeader($this->_io, $this, $this->_root);
            $this->_m_unknownWeights = $this->_io->readS4le();
            $this->_m_padding1 = [];
            $n = 8;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_padding1[] = $this->_io->readU1();
            }
            $this->_m_mdxBoneWeightsOffset = $this->_io->readU4le();
            $this->_m_mdxBoneIndicesOffset = $this->_io->readU4le();
            $this->_m_boneMapOffset = $this->_io->readU4le();
            $this->_m_boneMapCount = $this->_io->readU4le();
            $this->_m_qbonesOffset = $this->_io->readU4le();
            $this->_m_qbonesCount = $this->_io->readU4le();
            $this->_m_qbonesCountDuplicate = $this->_io->readU4le();
            $this->_m_tbonesOffset = $this->_io->readU4le();
            $this->_m_tbonesCount = $this->_io->readU4le();
            $this->_m_tbonesCountDuplicate = $this->_io->readU4le();
            $this->_m_unknownArray = $this->_io->readU4le();
            $this->_m_boneNodeSerialNumbers = [];
            $n = 16;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_boneNodeSerialNumbers[] = $this->_io->readU2le();
            }
            $this->_m_padding2 = $this->_io->readU2le();
        }
        protected $_m_trimeshBase;
        protected $_m_unknownWeights;
        protected $_m_padding1;
        protected $_m_mdxBoneWeightsOffset;
        protected $_m_mdxBoneIndicesOffset;
        protected $_m_boneMapOffset;
        protected $_m_boneMapCount;
        protected $_m_qbonesOffset;
        protected $_m_qbonesCount;
        protected $_m_qbonesCountDuplicate;
        protected $_m_tbonesOffset;
        protected $_m_tbonesCount;
        protected $_m_tbonesCountDuplicate;
        protected $_m_unknownArray;
        protected $_m_boneNodeSerialNumbers;
        protected $_m_padding2;

        /**
         * Standard trimesh header
         */
        public function trimeshBase() { return $this->_m_trimeshBase; }

        /**
         * Purpose unknown (possibly compilation weights)
         */
        public function unknownWeights() { return $this->_m_unknownWeights; }

        /**
         * Padding
         */
        public function padding1() { return $this->_m_padding1; }

        /**
         * Offset to bone weight data in MDX file (4 floats per vertex)
         */
        public function mdxBoneWeightsOffset() { return $this->_m_mdxBoneWeightsOffset; }

        /**
         * Offset to bone index data in MDX file (4 floats per vertex, cast to uint16)
         */
        public function mdxBoneIndicesOffset() { return $this->_m_mdxBoneIndicesOffset; }

        /**
         * Offset to bone map array (maps local bone indices to skeleton bone numbers)
         */
        public function boneMapOffset() { return $this->_m_boneMapOffset; }

        /**
         * Number of bones referenced by this mesh (max 16)
         */
        public function boneMapCount() { return $this->_m_boneMapCount; }

        /**
         * Offset to quaternion bind pose array (4 floats per bone)
         */
        public function qbonesOffset() { return $this->_m_qbonesOffset; }

        /**
         * Number of quaternion bind poses
         */
        public function qbonesCount() { return $this->_m_qbonesCount; }

        /**
         * Duplicate of QBones count
         */
        public function qbonesCountDuplicate() { return $this->_m_qbonesCountDuplicate; }

        /**
         * Offset to translation bind pose array (3 floats per bone)
         */
        public function tbonesOffset() { return $this->_m_tbonesOffset; }

        /**
         * Number of translation bind poses
         */
        public function tbonesCount() { return $this->_m_tbonesCount; }

        /**
         * Duplicate of TBones count
         */
        public function tbonesCountDuplicate() { return $this->_m_tbonesCountDuplicate; }

        /**
         * Purpose unknown
         */
        public function unknownArray() { return $this->_m_unknownArray; }

        /**
         * Serial indices of bone nodes (0xFFFF for unused slots)
         */
        public function boneNodeSerialNumbers() { return $this->_m_boneNodeSerialNumbers; }

        /**
         * Padding for alignment
         */
        public function padding2() { return $this->_m_padding2; }
    }
}

/**
 * Trimesh header (332 bytes KOTOR 1, 340 bytes KOTOR 2)
 */

namespace Mdl {
    class TrimeshHeader extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_functionPointer0 = $this->_io->readU4le();
            $this->_m_functionPointer1 = $this->_io->readU4le();
            $this->_m_facesArrayOffset = $this->_io->readU4le();
            $this->_m_facesCount = $this->_io->readU4le();
            $this->_m_facesCountDuplicate = $this->_io->readU4le();
            $this->_m_boundingBoxMin = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_boundingBoxMax = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_radius = $this->_io->readF4le();
            $this->_m_averagePoint = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_diffuseColor = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_ambientColor = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_transparencyHint = $this->_io->readU4le();
            $this->_m_texture0Name = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_texture1Name = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(32), 0, false), "ASCII");
            $this->_m_texture2Name = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(12), 0, false), "ASCII");
            $this->_m_texture3Name = \Kaitai\Struct\Stream::bytesToStr(\Kaitai\Struct\Stream::bytesTerminate($this->_io->readBytes(12), 0, false), "ASCII");
            $this->_m_indicesCountArrayOffset = $this->_io->readU4le();
            $this->_m_indicesCountArrayCount = $this->_io->readU4le();
            $this->_m_indicesCountArrayCountDuplicate = $this->_io->readU4le();
            $this->_m_indicesOffsetArrayOffset = $this->_io->readU4le();
            $this->_m_indicesOffsetArrayCount = $this->_io->readU4le();
            $this->_m_indicesOffsetArrayCountDuplicate = $this->_io->readU4le();
            $this->_m_invertedCounterArrayOffset = $this->_io->readU4le();
            $this->_m_invertedCounterArrayCount = $this->_io->readU4le();
            $this->_m_invertedCounterArrayCountDuplicate = $this->_io->readU4le();
            $this->_m_unknownValues = [];
            $n = 3;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_unknownValues[] = $this->_io->readS4le();
            }
            $this->_m_saberUnknownData = [];
            $n = 8;
            for ($i = 0; $i < $n; $i++) {
                $this->_m_saberUnknownData[] = $this->_io->readU1();
            }
            $this->_m_unknown = $this->_io->readU4le();
            $this->_m_uvDirection = new \Mdl\Vec3f($this->_io, $this, $this->_root);
            $this->_m_uvJitter = $this->_io->readF4le();
            $this->_m_uvJitterSpeed = $this->_io->readF4le();
            $this->_m_mdxVertexSize = $this->_io->readU4le();
            $this->_m_mdxDataFlags = $this->_io->readU4le();
            $this->_m_mdxVerticesOffset = $this->_io->readS4le();
            $this->_m_mdxNormalsOffset = $this->_io->readS4le();
            $this->_m_mdxVertexColorsOffset = $this->_io->readS4le();
            $this->_m_mdxTex0UvsOffset = $this->_io->readS4le();
            $this->_m_mdxTex1UvsOffset = $this->_io->readS4le();
            $this->_m_mdxTex2UvsOffset = $this->_io->readS4le();
            $this->_m_mdxTex3UvsOffset = $this->_io->readS4le();
            $this->_m_mdxTangentSpaceOffset = $this->_io->readS4le();
            $this->_m_mdxUnknownOffset1 = $this->_io->readS4le();
            $this->_m_mdxUnknownOffset2 = $this->_io->readS4le();
            $this->_m_mdxUnknownOffset3 = $this->_io->readS4le();
            $this->_m_vertexCount = $this->_io->readU2le();
            $this->_m_textureCount = $this->_io->readU2le();
            $this->_m_lightmapped = $this->_io->readU1();
            $this->_m_rotateTexture = $this->_io->readU1();
            $this->_m_backgroundGeometry = $this->_io->readU1();
            $this->_m_shadow = $this->_io->readU1();
            $this->_m_beaming = $this->_io->readU1();
            $this->_m_render = $this->_io->readU1();
            $this->_m_unknownFlag = $this->_io->readU1();
            $this->_m_padding = $this->_io->readU1();
            $this->_m_totalArea = $this->_io->readF4le();
            $this->_m_unknown2 = $this->_io->readU4le();
            if ($this->_root()->modelHeader()->geometry()->isKotor2()) {
                $this->_m_k2Unknown1 = $this->_io->readU4le();
            }
            if ($this->_root()->modelHeader()->geometry()->isKotor2()) {
                $this->_m_k2Unknown2 = $this->_io->readU4le();
            }
            $this->_m_mdxDataOffset = $this->_io->readU4le();
            $this->_m_mdlVerticesOffset = $this->_io->readU4le();
        }
        protected $_m_functionPointer0;
        protected $_m_functionPointer1;
        protected $_m_facesArrayOffset;
        protected $_m_facesCount;
        protected $_m_facesCountDuplicate;
        protected $_m_boundingBoxMin;
        protected $_m_boundingBoxMax;
        protected $_m_radius;
        protected $_m_averagePoint;
        protected $_m_diffuseColor;
        protected $_m_ambientColor;
        protected $_m_transparencyHint;
        protected $_m_texture0Name;
        protected $_m_texture1Name;
        protected $_m_texture2Name;
        protected $_m_texture3Name;
        protected $_m_indicesCountArrayOffset;
        protected $_m_indicesCountArrayCount;
        protected $_m_indicesCountArrayCountDuplicate;
        protected $_m_indicesOffsetArrayOffset;
        protected $_m_indicesOffsetArrayCount;
        protected $_m_indicesOffsetArrayCountDuplicate;
        protected $_m_invertedCounterArrayOffset;
        protected $_m_invertedCounterArrayCount;
        protected $_m_invertedCounterArrayCountDuplicate;
        protected $_m_unknownValues;
        protected $_m_saberUnknownData;
        protected $_m_unknown;
        protected $_m_uvDirection;
        protected $_m_uvJitter;
        protected $_m_uvJitterSpeed;
        protected $_m_mdxVertexSize;
        protected $_m_mdxDataFlags;
        protected $_m_mdxVerticesOffset;
        protected $_m_mdxNormalsOffset;
        protected $_m_mdxVertexColorsOffset;
        protected $_m_mdxTex0UvsOffset;
        protected $_m_mdxTex1UvsOffset;
        protected $_m_mdxTex2UvsOffset;
        protected $_m_mdxTex3UvsOffset;
        protected $_m_mdxTangentSpaceOffset;
        protected $_m_mdxUnknownOffset1;
        protected $_m_mdxUnknownOffset2;
        protected $_m_mdxUnknownOffset3;
        protected $_m_vertexCount;
        protected $_m_textureCount;
        protected $_m_lightmapped;
        protected $_m_rotateTexture;
        protected $_m_backgroundGeometry;
        protected $_m_shadow;
        protected $_m_beaming;
        protected $_m_render;
        protected $_m_unknownFlag;
        protected $_m_padding;
        protected $_m_totalArea;
        protected $_m_unknown2;
        protected $_m_k2Unknown1;
        protected $_m_k2Unknown2;
        protected $_m_mdxDataOffset;
        protected $_m_mdlVerticesOffset;

        /**
         * Game engine function pointer (version-specific)
         */
        public function functionPointer0() { return $this->_m_functionPointer0; }

        /**
         * Secondary game engine function pointer
         */
        public function functionPointer1() { return $this->_m_functionPointer1; }

        /**
         * Offset to face definitions array
         */
        public function facesArrayOffset() { return $this->_m_facesArrayOffset; }

        /**
         * Number of triangular faces in mesh
         */
        public function facesCount() { return $this->_m_facesCount; }

        /**
         * Duplicate of faces count
         */
        public function facesCountDuplicate() { return $this->_m_facesCountDuplicate; }

        /**
         * Minimum bounding box coordinates (X, Y, Z)
         */
        public function boundingBoxMin() { return $this->_m_boundingBoxMin; }

        /**
         * Maximum bounding box coordinates (X, Y, Z)
         */
        public function boundingBoxMax() { return $this->_m_boundingBoxMax; }

        /**
         * Bounding sphere radius
         */
        public function radius() { return $this->_m_radius; }

        /**
         * Average vertex position (centroid) X, Y, Z
         */
        public function averagePoint() { return $this->_m_averagePoint; }

        /**
         * Material diffuse color (R, G, B, range 0.0-1.0)
         */
        public function diffuseColor() { return $this->_m_diffuseColor; }

        /**
         * Material ambient color (R, G, B, range 0.0-1.0)
         */
        public function ambientColor() { return $this->_m_ambientColor; }

        /**
         * Transparency rendering mode
         */
        public function transparencyHint() { return $this->_m_transparencyHint; }

        /**
         * Primary diffuse texture name (null-terminated string)
         */
        public function texture0Name() { return $this->_m_texture0Name; }

        /**
         * Secondary texture name, often lightmap (null-terminated string)
         */
        public function texture1Name() { return $this->_m_texture1Name; }

        /**
         * Tertiary texture name (null-terminated string)
         */
        public function texture2Name() { return $this->_m_texture2Name; }

        /**
         * Quaternary texture name (null-terminated string)
         */
        public function texture3Name() { return $this->_m_texture3Name; }

        /**
         * Offset to vertex indices count array
         */
        public function indicesCountArrayOffset() { return $this->_m_indicesCountArrayOffset; }

        /**
         * Number of entries in indices count array
         */
        public function indicesCountArrayCount() { return $this->_m_indicesCountArrayCount; }

        /**
         * Duplicate of indices count array count
         */
        public function indicesCountArrayCountDuplicate() { return $this->_m_indicesCountArrayCountDuplicate; }

        /**
         * Offset to vertex indices offset array
         */
        public function indicesOffsetArrayOffset() { return $this->_m_indicesOffsetArrayOffset; }

        /**
         * Number of entries in indices offset array
         */
        public function indicesOffsetArrayCount() { return $this->_m_indicesOffsetArrayCount; }

        /**
         * Duplicate of indices offset array count
         */
        public function indicesOffsetArrayCountDuplicate() { return $this->_m_indicesOffsetArrayCountDuplicate; }

        /**
         * Offset to inverted counter array
         */
        public function invertedCounterArrayOffset() { return $this->_m_invertedCounterArrayOffset; }

        /**
         * Number of entries in inverted counter array
         */
        public function invertedCounterArrayCount() { return $this->_m_invertedCounterArrayCount; }

        /**
         * Duplicate of inverted counter array count
         */
        public function invertedCounterArrayCountDuplicate() { return $this->_m_invertedCounterArrayCountDuplicate; }

        /**
         * Typically {-1, -1, 0}, purpose unknown
         */
        public function unknownValues() { return $this->_m_unknownValues; }

        /**
         * Data specific to lightsaber meshes
         */
        public function saberUnknownData() { return $this->_m_saberUnknownData; }

        /**
         * Purpose unknown
         */
        public function unknown() { return $this->_m_unknown; }

        /**
         * UV animation direction X, Y components (Z = jitter speed)
         */
        public function uvDirection() { return $this->_m_uvDirection; }

        /**
         * UV animation jitter amount
         */
        public function uvJitter() { return $this->_m_uvJitter; }

        /**
         * UV animation jitter speed
         */
        public function uvJitterSpeed() { return $this->_m_uvJitterSpeed; }

        /**
         * Size in bytes of each vertex in MDX data
         */
        public function mdxVertexSize() { return $this->_m_mdxVertexSize; }

        /**
         * Bitmask of present vertex attributes:
         * - 0x00000001: MDX_VERTICES (vertex positions)
         * - 0x00000002: MDX_TEX0_VERTICES (primary texture coordinates)
         * - 0x00000004: MDX_TEX1_VERTICES (secondary texture coordinates)
         * - 0x00000008: MDX_TEX2_VERTICES (tertiary texture coordinates)
         * - 0x00000010: MDX_TEX3_VERTICES (quaternary texture coordinates)
         * - 0x00000020: MDX_VERTEX_NORMALS (vertex normals)
         * - 0x00000040: MDX_VERTEX_COLORS (vertex colors)
         * - 0x00000080: MDX_TANGENT_SPACE (tangent space data)
         */
        public function mdxDataFlags() { return $this->_m_mdxDataFlags; }

        /**
         * Relative offset to vertex positions in MDX (or -1 if none)
         */
        public function mdxVerticesOffset() { return $this->_m_mdxVerticesOffset; }

        /**
         * Relative offset to vertex normals in MDX (or -1 if none)
         */
        public function mdxNormalsOffset() { return $this->_m_mdxNormalsOffset; }

        /**
         * Relative offset to vertex colors in MDX (or -1 if none)
         */
        public function mdxVertexColorsOffset() { return $this->_m_mdxVertexColorsOffset; }

        /**
         * Relative offset to primary texture UVs in MDX (or -1 if none)
         */
        public function mdxTex0UvsOffset() { return $this->_m_mdxTex0UvsOffset; }

        /**
         * Relative offset to secondary texture UVs in MDX (or -1 if none)
         */
        public function mdxTex1UvsOffset() { return $this->_m_mdxTex1UvsOffset; }

        /**
         * Relative offset to tertiary texture UVs in MDX (or -1 if none)
         */
        public function mdxTex2UvsOffset() { return $this->_m_mdxTex2UvsOffset; }

        /**
         * Relative offset to quaternary texture UVs in MDX (or -1 if none)
         */
        public function mdxTex3UvsOffset() { return $this->_m_mdxTex3UvsOffset; }

        /**
         * Relative offset to tangent space data in MDX (or -1 if none)
         */
        public function mdxTangentSpaceOffset() { return $this->_m_mdxTangentSpaceOffset; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public function mdxUnknownOffset1() { return $this->_m_mdxUnknownOffset1; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public function mdxUnknownOffset2() { return $this->_m_mdxUnknownOffset2; }

        /**
         * Relative offset to unknown MDX data (or -1 if none)
         */
        public function mdxUnknownOffset3() { return $this->_m_mdxUnknownOffset3; }

        /**
         * Number of vertices in mesh
         */
        public function vertexCount() { return $this->_m_vertexCount; }

        /**
         * Number of textures used by mesh
         */
        public function textureCount() { return $this->_m_textureCount; }

        /**
         * 1 if mesh uses lightmap, 0 otherwise
         */
        public function lightmapped() { return $this->_m_lightmapped; }

        /**
         * 1 if texture should rotate, 0 otherwise
         */
        public function rotateTexture() { return $this->_m_rotateTexture; }

        /**
         * 1 if background geometry, 0 otherwise
         */
        public function backgroundGeometry() { return $this->_m_backgroundGeometry; }

        /**
         * 1 if mesh casts shadows, 0 otherwise
         */
        public function shadow() { return $this->_m_shadow; }

        /**
         * 1 if beaming effect enabled, 0 otherwise
         */
        public function beaming() { return $this->_m_beaming; }

        /**
         * 1 if mesh is renderable, 0 if hidden
         */
        public function render() { return $this->_m_render; }

        /**
         * Purpose unknown (possibly UV animation enable)
         */
        public function unknownFlag() { return $this->_m_unknownFlag; }

        /**
         * Padding byte
         */
        public function padding() { return $this->_m_padding; }

        /**
         * Total surface area of all faces
         */
        public function totalArea() { return $this->_m_totalArea; }

        /**
         * Purpose unknown
         */
        public function unknown2() { return $this->_m_unknown2; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        public function k2Unknown1() { return $this->_m_k2Unknown1; }

        /**
         * KOTOR 2 only: Additional unknown field
         */
        public function k2Unknown2() { return $this->_m_k2Unknown2; }

        /**
         * Absolute offset to this mesh's vertex data in MDX file
         */
        public function mdxDataOffset() { return $this->_m_mdxDataOffset; }

        /**
         * Offset to vertex coordinate array in MDL file (for walkmesh/AABB nodes)
         */
        public function mdlVerticesOffset() { return $this->_m_mdlVerticesOffset; }
    }
}

/**
 * 3D vector (3 floats)
 */

namespace Mdl {
    class Vec3f extends \Kaitai\Struct\Struct {
        public function __construct(\Kaitai\Struct\Stream $_io, ?\Kaitai\Struct\Struct $_parent = null, ?\Mdl $_root = null) {
            parent::__construct($_io, $_parent, $_root);
            $this->_read();
        }

        private function _read() {
            $this->_m_x = $this->_io->readF4le();
            $this->_m_y = $this->_io->readF4le();
            $this->_m_z = $this->_io->readF4le();
        }
        protected $_m_x;
        protected $_m_y;
        protected $_m_z;
        public function x() { return $this->_m_x; }
        public function y() { return $this->_m_y; }
        public function z() { return $this->_m_z; }
    }
}
