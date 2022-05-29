package org.devpro.market;

import net.dv8tion.jda.api.Permission;
import net.dv8tion.jda.api.entities.*;
import net.dv8tion.jda.api.events.interaction.command.SlashCommandInteractionEvent;
import net.dv8tion.jda.api.managers.channel.concrete.CategoryManager;
import org.devpro.main.Globals;
import org.devpro.main.Main;

import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Consumer;

public class MarketManager {

    private static ConcurrentHashMap<String, PostBuilder> posts = new ConcurrentHashMap<>();

    private static HashMap<String, Consumer<SlashCommandInteractionEvent>> methods = new HashMap<>() {{
        put("hire", Hiring::hire);
        put("unreserve", MarketManager::unreserve);
    }};


    public static Consumer<SlashCommandInteractionEvent> getMethodFor(String key) {
        return methods.getOrDefault(key, e -> {});
    }

     public static void setupIfAbsent(Guild gld) {
        for (String name : Globals.Init.PRIVATE_CATEGORIES) {
            List<Category> categories = gld.getCategoriesByName(name, true);
            Category category = categories.isEmpty() ? gld.createCategory(name).complete() : categories.get(0);
            CategoryManager manager = category.getManager();

            for (String channel: Globals.Init.CHANNELS.getOrDefault(name, new String[0]))
                category.createTextChannel(channel).syncPermissionOverrides().queue();

            // Give the role @everyone no permissions.
            // RoleID of @everyone is the same as Guild ID.
            manager.putRolePermissionOverride(Globals.GUILD_ID, 0, Permission.ALL_CHANNEL_PERMISSIONS).queue();
        }

         for (String name : Globals.Init.PUBLIC_CATEGORIES) {
             List<Category> categories = gld.getCategoriesByName(name, true);
             Category category = categories.isEmpty() ? gld.createCategory(name).complete() : categories.get(0);
             CategoryManager manager = category.getManager();

             for (String channel: Globals.Init.CHANNELS.getOrDefault(name, new String[0]))
                 category.createTextChannel(channel).syncPermissionOverrides().queue();

             // Give the role @everyone read-only permissions.
             // RoleID of @everyone is the same as Guild ID.
             manager.putRolePermissionOverride(Globals.GUILD_ID, Globals.Permissions.READ_ONLY, Globals.Permissions.WRITE).queue();
         }
     }

    protected static Channel getReservedChannel(Guild gld, String category, String uid) {
        List<Category> l = gld.getCategoriesByName(category, true);
        if (l.isEmpty()) return null;

        return l.get(0)
                .getChannels()
                .stream()
                .filter(chan -> chan.getName().equals(category + "-" + uid))
                .findAny()
                .orElse(null);
    }

    protected static TextChannel createChannel(Guild gld, String category, String uid) {

        String name = category + "-" + uid;
        TextChannel chan = gld
                .getCategoriesByName(category,true)
                .get(0)
                .createTextChannel(name)
                .complete();

        // TODO: Post builder setup (+ constructor)
        posts.put(name, new PostBuilder());

        chan.upsertPermissionOverride(gld.getMemberById(uid)).setAllowed(Globals.Permissions.READ_WRITE).queue();

        return chan;
    }

    public static void unreserve(SlashCommandInteractionEvent e) throws IllegalStateException {

    }
}
