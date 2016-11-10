package com.continuum.nova.launcher;

import java.io.File;
import java.util.List;

import net.minecraft.launchwrapper.LaunchClassLoader;

public class NovaServerTweaker extends NovaTweaker
{
    @Override
    public void acceptOptions(List<String> args, File gameDir, File assetsDir, String profile) {
    }

    @Override
    public void injectIntoClassLoader(LaunchClassLoader classLoader) {
    }

    @Override
    public String getLaunchTarget() {
        return "net.minecraft.server.MinecraftServer";
    }
}
