package org.devpro.main;

import net.dv8tion.jda.api.events.ReadyEvent;
import net.dv8tion.jda.api.events.guild.GuildJoinEvent;
import org.devpro.market.MarketManager;

import net.dv8tion.jda.api.entities.*;
import net.dv8tion.jda.api.events.interaction.command.SlashCommandInteractionEvent;
import net.dv8tion.jda.api.events.message.MessageReceivedEvent;
import net.dv8tion.jda.api.hooks.ListenerAdapter;

public class BotEventListener extends ListenerAdapter {
    @Override
    public void onMessageReceived(MessageReceivedEvent mre) {
        // ignore System and Bot messages.
        if (mre.getAuthor().isSystem() || mre.getAuthor().isBot())
            return;

        Message msg = mre.getMessage();
        if (msg.getContentRaw().trim().equals("!ping"))
            msg.getChannel().sendMessage("Pong!").queue();
        else
            msg.getChannel().sendMessage("WDYM").queue();
    }

    @Override
    public void onSlashCommandInteraction(SlashCommandInteractionEvent e) {
        String path = e.getCommandPath();

        // The test command
        if (path.equals("test")) {
            e.getOption("message", () -> {
                e.getChannel().sendMessage("**No Message Received**").queue();
                return null;
            }, m -> {
                e.getChannel().sendMessage("**Received Message:** " + m.getAsString()).queue();
                return null;
            });
        }

        // The Market command. Redirect to Market.
        String[] parts = path.split("/");
        if (parts[0].equals("market")) {
            MarketManager.getMethodFor(parts[1]).accept(e);
        }
    }

    @Override
    public void onReady(ReadyEvent e) {
        for (Guild gd: e.getJDA().getGuilds())
            MarketManager.setupIfAbsent(gd);
    }
}
