set commentstring=//\ %s

syn keyword cExtraType
	\ i8 i16 i32 i64
	\ u8 u16 u32 u64
	\ b8 b16 b32 b64
	\ I8 I16 I32 I64
	\ isize usize uint uintptr byte
	\ cstring string rune
	\ f16 f32 f64

syn keyword cExtraTypeUpper
	\ U8 U16 U32 U64
	\ B8 B16 B32 B64
	\ Size Uintptr Int Intptr Rune Byte
	\ F16 F32 F64

syn keyword cExtraTypeAtomic
	\ atomic_i8 atomic_i16 atomic_i32 atomic_i64
	\ atomic_u8 atomic_u16 atomic_u32 atomic_u64
	\ atomic_b8 atomic_b16 atomic_b32 atomic_b64
	\ atomic_isize atomic_usize atomic_uint atomic_uintptr atomic_byte
	\ atomic_f16 atomic_f32 atomic_f64

syn keyword cExtraTypeAtomicUpper
	\ AtomicI8 AtomicI16 AtomicI32 AtomicI64
	\ AtomicU8 AtomicU16 AtomicU32 AtomicU64
	\ AtomicB8 AtomicB16 AtomicB32 AtomicB64
	\ AtomicSize AtomicUint AtomicUintptr AtomicByte
	\ AtomicF16 AtomicF32 AtomicF64

syn keyword Keyword typedef sizeof alignof decltype default case
syn match cppNamespace '\v\zs\i+\ze(\<.{-}\>)?\s*::\s*\i+'
syn match cAttribute '\v\[\[.{-}\]\]'

syn keyword cType true false NULL

syn clear cStructure

syn keyword cDeFactoConstant true false NULL nullptr

syn match cStructKw '\v(struct|union|enum)' contained
syn match cStructure '\zs\v(struct|union|enum)\s*(\i+)?\ze\s*\{?' contains=cStructKw

hi! link cStructure Type
hi! link cStructKw Keyword

hi! link cDeFactoConstant Keyword
hi! link cStructure Type
hi! link cStructKw Keyword
hi! link cppNamespace Type
hi! link cAttribute Type
hi! link cExtraType Type
hi! link cExtraTypeAtomic Type
hi! link cExtraTypeUpper Type
hi! link cExtraTypeAtomicUpper Type

