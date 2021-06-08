//! workaround github.com/microsoft/win32metadata/issues/395
const std = @import("std");
pub const std_handle_types = std.ComptimeStringMap([]const u8, .{
    .{ "HANDLE", "os.windows.HANDLE" },
    .{ "SOCKET", "os.socket_t" },
});
pub const handle_types = list: {
    @setEvalBranchQuota(3000);
    break :list std.ComptimeStringMap(struct{}, .{
        .{ "HICON", .{} },
        .{ "HCURSOR", .{} },
        .{ "HBRUSH", .{} },
        .{ "HSYNTHETICPOINTERDEVICE", .{} },
        .{ "HPROPSHEETPAGE", .{} },
        .{ "HIMAGELIST", .{} },
        .{ "HTREEITEM", .{} },
        .{ "HCOLORSPACE", .{} },
        .{ "HCRYPTASYNC", .{} },
        .{ "HCERTCHAINENGINE", .{} },
        .{ "HCOMDB", .{} },
        .{ "HKEY", .{} },
        .{ "HWINWATCH", .{} },
        .{ "HWINSTA", .{} },
        .{ "HDESK", .{} },
        .{ "HSTRING", .{} },
        .{ "HSZ", .{} },
        .{ "HCONV", .{} },
        .{ "HCONVLIST", .{} },
        .{ "HDDEDATA", .{} },
        .{ "HRASCONN", .{} },
        .{ "HAMSICONTEXT", .{} },
        .{ "HAMSISESSION", .{} },
        .{ "HCMNOTIFICATION", .{} },
        .{ "HKL", .{} },
        .{ "HIFTIMESTAMPCHANGE", .{} },
        .{ "HWSAEVENT", .{} },
        .{ "HTASK", .{} },
        .{ "HWINEVENTHOOK", .{} },
        .{ "HUIANODE", .{} },
        .{ "HUIAPATTERNOBJECT", .{} },
        .{ "HUIATEXTRANGE", .{} },
        .{ "HUIAEVENT", .{} },
        .{ "HMIDI", .{} },
        .{ "HMIDIIN", .{} },
        .{ "HMIDIOUT", .{} },
        .{ "HMIDISTRM", .{} },
        .{ "HMIXER", .{} },
        .{ "HMIXEROBJ", .{} },
        .{ "HWAVE", .{} },
        .{ "HWAVEOUT", .{} },
        .{ "HWAVEIN", .{} },
        .{ "HMMIO", .{} },
        .{ "HDRVR", .{} },
        .{ "HACMDRIVERID", .{} },
        .{ "HACMDRIVER", .{} },
        .{ "HACMSTREAM", .{} },
        .{ "HACMOBJ", .{} },
        .{ "HIC", .{} },
        .{ "HVIDEO", .{} },
        .{ "HSWDEVICE", .{} },
        .{ "HINTERACTIONCONTEXT", .{} },
        .{ "HRAWINPUT", .{} },
        .{ "HRECOALT", .{} },
        .{ "HRECOCONTEXT", .{} },
        .{ "HRECOGNIZER", .{} },
        .{ "HRECOLATTICE", .{} },
        .{ "HRECOWORDLIST", .{} },
        .{ "HIMC", .{} },
        .{ "HIMCC", .{} },
        .{ "HSAVEDUILANGUAGES", .{} },
        .{ "HRSRC", .{} },
        .{ "HSURF", .{} },
        .{ "HINSTANCE", .{} },
        .{ "HPOWERNOTIFY", .{} },
        .{ "HUMPD", .{} },
        .{ "HSTR", .{} },
        .{ "HSPRITE", .{} },
        .{ "HSEMAPHORE", .{} },
        .{ "HLSURF", .{} },
        .{ "HFASTMUTEX", .{} },
        .{ "HDRVOBJ", .{} },
        .{ "HDEV", .{} },
        .{ "HBM", .{} },
        .{ "HPCON", .{} },
        .{ "HMENU", .{} },
        .{ "HACCEL", .{} },
        .{ "HDROP", .{} },
        .{ "HPSXA", .{} },
        .{ "HDC", .{} },
        .{ "HGDIOBJ", .{} },
        .{ "HBITMAP", .{} },
        .{ "HRGN", .{} },
        .{ "HPEN", .{} },
        .{ "HBRUSH", .{} },
        .{ "HFONT", .{} },
        .{ "HMETAFILE", .{} },
        .{ "HENHMETAFILE", .{} },
        .{ "HMONITOR", .{} },
        .{ "HPALETTE", .{} },
        .{ "HWND", .{} },
        .{ "HHOOK", .{} },
        .{ "HGESTUREINFO", .{} },
        .{ "HTOUCHINPUT", .{} },
        .{ "HGLRC", .{} },
        .{ "HFILTER", .{} },
        .{ "HPTPROVIDER", .{} },
        .{ "HPSS", .{} },
        .{ "HPSSWALK", .{} },
        .{ "HSTRING_BUFFER", .{} },
        .{ "JET_SESID", .{} },
        .{ "PSID", .{} },
        .{ "AUTHZ_AUDIT_EVENT_HANDLE", .{} },
        .{ "HeapHandle", .{} },
    });
};
