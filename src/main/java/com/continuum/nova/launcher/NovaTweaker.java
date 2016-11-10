package com.continuum.nova.launcher;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import net.minecraft.launchwrapper.ITweaker;
import net.minecraft.launchwrapper.Launch;
import net.minecraft.launchwrapper.LaunchClassLoader;

public class NovaTweaker implements ITweaker {
    private Map<String, String> launchArgs;
    private List<String> standaloneArgs;

    @Override
    public void acceptOptions(List<String> args, File gameDir, File assetsDir, String profile) {
        this.launchArgs = (Map<String, String>)Launch.blackboard.get("launchArgs");

        this.standaloneArgs = Lists.newArrayList();
        if (this.launchArgs == null) {
            this.launchArgs = Maps.newHashMap();
            Launch.blackboard.put("launchArgs", this.launchArgs);
        }

        String classifier = null;

        for (String arg : args) {
            if (arg.startsWith("-")) {
                if (classifier != null) {
                    classifier = launchArgs.put(classifier, "");
                } else if (arg.contains("=")) {
                    classifier = launchArgs.put(arg.substring(0, arg.indexOf('=')), arg.substring(arg.indexOf('=') + 1));
                } else {
                    classifier = arg;
                }
            } else {
                if (classifier != null) {
                    classifier = launchArgs.put(classifier, arg);
                } else {
                    this.standaloneArgs.add(arg);
                }
            }
        }

        if (!this.launchArgs.containsKey("--version")) {
            launchArgs.put("--version", profile != null ? profile : "UnknownFMLProfile");
        }

        if (!this.launchArgs.containsKey("--gameDir") && gameDir != null) {
            launchArgs.put("--gameDir", gameDir.getAbsolutePath());
        }

        if (!this.launchArgs.containsKey("--assetsDir") && assetsDir != null) {
            launchArgs.put("--assetsDir", assetsDir.getAbsolutePath());
        }

        Yggdrasil.login(launchArgs);
    }

    @Override
    public void injectIntoClassLoader(LaunchClassLoader classLoader) {
    }

    @Override
    public String getLaunchTarget() {
        return "net.minecraft.client.main.Main";
    }

    @Override
    public String[] getLaunchArguments() {
        List<String> args = Lists.newArrayList();
        args.addAll(standaloneArgs);

        for (Entry<String, String> arg : launchArgs.entrySet()) {
            args.add(arg.getKey());
            args.add(arg.getValue());
        }
        launchArgs.clear();

        return args.toArray(new String[args.size()]);
    }
    
}
