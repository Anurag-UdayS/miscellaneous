package org.devpro.market;

import net.dv8tion.jda.api.entities.*;
import net.dv8tion.jda.api.events.interaction.command.SlashCommandInteractionEvent;

import org.devpro.enums.MessageEnum;
import org.devpro.utils.MessagingUtil;

public class Hiring {

    public static void hire(SlashCommandInteractionEvent e) throws IllegalStateException {
        Guild gld = e.getGuild();
        String uid = e.getUser().getId();
        Channel reserved = MarketManager.getReservedChannel(gld, "hiring", uid);


        if (reserved != null) {
            e.deferReply(true)
                .addEmbeds(
                    MessagingUtil.buildErrorEmbed(MessageEnum.get(MessageEnum.CHANNEL_RESERVED_FAILURE, reserved.getAsMention())))
                .queue();
            return;
        }

        reserved = MarketManager.createChannel(gld, "hiring", uid);
        e.deferReply(true)
            .addEmbeds(
                MessagingUtil.buildSuccessEmbed(MessageEnum.get(MessageEnum.CHANNEL_RESERVED_SUCCESS, reserved.getAsMention())))
            .queue();

    }

}
