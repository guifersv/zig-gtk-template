const std = @import("std");
const gtk = @import("gtk");
const gio = @import("gio");

pub fn main() !void {
    var app = gtk.Application.new("org.gtk.name", .{});
    defer app.unref();

    _ = gio.Application.signals.activate.connect(app, ?*anyopaque, &activate, null, .{});
    const status = gio.Application.run(app.as(gio.Application), @intCast(std.os.argv.len), std.os.argv.ptr);
    std.process.exit(@intCast(status));
}

pub fn activate(app: *gtk.Application, _: ?*anyopaque) callconv(.c) void {
    const window = gtk.ApplicationWindow.new(app).as(gtk.Window);
    gtk.Window.setTitle(window, "Window");
    gtk.Window.setDefaultSize(window, 200, 200);
    gtk.Window.present(window);
}
