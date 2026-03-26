const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const gobject = b.dependency("gobject", .{
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "name",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                // .{ .name = "glib", .module = gobject.module("glib2") },
                // .{ .name = "gobject", .module = gobject.module("gobject2") },
                // .{ .name = "cairo", .module = gobject.module("cairo1") },
                // .{ .name = "pango", .module = gobject.module("pango1") },
                // .{ .name = "pangocairo", .module = gobject.module("pangocairo1") },
                // .{ .name = "gdk", .module = gobject.module("gdk4") },
                .{ .name = "gio", .module = gobject.module("gio2") },
                .{ .name = "gtk", .module = gobject.module("gtk4") },
            },
        }),
    });

    b.installArtifact(exe);

    const exe_cmd = b.addRunArtifact(exe);

    exe_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        exe_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&exe_cmd.step);
}
