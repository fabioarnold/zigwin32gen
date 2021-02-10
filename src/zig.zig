//! This module is maintained by hand and is copied to the generated code directory
const std = @import("std");
const testing = std.testing;

const root = @import("root");
pub const UnicodeMode = enum { ansi, wide, unspecified };
// WORKAROUND: https://github.com/ziglang/zig/issues/7979
// using root.UNICODE causes an erroneous dependency loop, so I'm hardcoding to .wide for now
pub const unicode_mode = UnicodeMode.wide;
//pub const unicode_mode : UnicodeMode = if (@hasDecl(root, "UNICODE")) (if (root.UNICODE) .wide else .ansi) else .unspecified;

pub const L = std.unicode.utf8ToUtf16LeStringLiteral;

// TODO: this should probably be in the standard lib somewhere?
pub const Guid = extern struct {
    bytes: [16]u8,

    const hex_offsets = [16] u6 {0, 2, 4, 6, 9, 11, 14, 16, 19, 21, 24, 26, 28, 30, 32, 34};

    pub fn initString(s: []const u8) Guid {
        var guid : Guid = undefined;
        for (hex_offsets) |hex_offset, i| {
            //guid.bytes[i] = decodeHexByte(s[offset..offset+2]);
            guid.bytes[i] = decodeHexByte([2]u8 { s[hex_offset], s[hex_offset+1] });
        }
        return guid;
    }
};

// TODO: is this in the standard lib somewhere?
fn hexVal(c: u8) u4 {
    if (c <= '9') return @intCast(u4, c - '0');
    if (c >= 'a') return @intCast(u4, c + 10 - 'a');
    return @intCast(u4, c + 10 - 'A');
}

// TODO: is this in the standard lib somewhere?
fn decodeHexByte(hex: [2]u8) u8 {
    return @intCast(u8, hexVal(hex[0])) << 4 | hexVal(hex[1]);
}

test "Guid" {
    testing.expect(std.mem.eql(u8,
        "\x01\x23\x45\x67\x89\xAB\xEF\x10\x32\x54\x76\x98\xba\xdc\xfe\x91",
        &Guid.initString("01234567-89AB-EF10-3254-7698badcfe91").bytes));
}

pub fn FAILED(hr: @import("api/com.zig").HRESULT) bool {
    return hr < 0;
}

//
// I used this typedConstant function with the old metadata (https://github.com/marler8997/windows-api)
// but I may not need it with the new metadata (https://github.com/marlersoft/win32json)
//
///// Converts comptime values to the given type.
///// Note that this function is called at compile time rather than converting constant values earlier at code generation time.
///// The reason for doing it a compile time is because genzig.zig generates all constants as they are encountered which can
///// be before it knows the constant's type definition, so we delay the convession to compile-time where the compiler knows
///// all type definition.
//pub fn typedConstant(comptime T: type, comptime value: anytype) T {
//    const target_type_error = @as([]const u8, "typedConstant cannot convert to " ++ @typeName(T));
//    const value_type_error = @as([]const u8, "typedConstant cannot convert " ++ @typeName(@TypeOf(value)) ++ " to " ++ @typeName(T));
//    switch (@typeInfo(T)) {
//        .Int => |target_type_info| {
//            if (value >= std.math.maxInt(T)) {
//                if (target_type_info.is_signed) {
//                    const UnsignedT = @Type(std.builtin.TypeInfo { .Int = .{ .is_signed = false, .bits = target_type_info.bits }});
//                    return @bitCast(T, @as(UnsignedT, value));
//                }
//            }
//            return value;
//        },
//        .Pointer => |target_type_info| {
//            switch (target_type_info.size) {
//                .One, .Many, .C => {
//                    switch (@typeInfo(@TypeOf(value))) {
//                        .ComptimeInt => |_| {
//                            const usize_value = if (value >= 0) value else @bitCast(usize, @as(isize, value));
//                            return @intToPtr(T, usize_value);
//                        },
//                        else => @compileError(value_type_error),
//                    }
//                },
//                else => target_type_error,
//            }
//        },
//        .Optional => |target_type_info| {
//            switch(@typeInfo(target_type_info.child)) {
//                .Pointer => return typedConstant(target_type_info.child, value),
//                else => target_type_error,
//            }
//        },
//        else => @compileError(target_type_error),
//    }
//}
//test "typedConstant" {
//    testing.expectEqual(@bitCast(usize, @as(isize, -1)),  @ptrToInt(typedConstant(?*opaque{}, -1)));
//    testing.expectEqual(@bitCast(usize, @as(isize, -12)),  @ptrToInt(typedConstant(?*opaque{}, -12)));
//    testing.expectEqual(@as(u32, 0xffffffff), typedConstant(u32, 0xffffffff));
//    testing.expectEqual(@bitCast(i32, @as(u32, 0x80000000)), typedConstant(i32, 0x80000000));
//}
//