package org.devpro.utils;

import net.dv8tion.jda.api.*;
import net.dv8tion.jda.api.entities.*;

import java.awt.*;

public class MessagingUtil {

    private static EmbedBuilder getEmbedBuilder(String title, String desc, Color col3, String author, String footer, EmbedField[] fields) {
        EmbedBuilder eb = new EmbedBuilder().setTitle(title).setDescription(desc).setColor(col3);
        if (author != null) eb.setAuthor(author);
        if (footer != null) eb.setFooter(footer);

        if (fields != null) for (EmbedField field: fields) eb.addField(field.name(), field.value(), true);

        return eb;
    }

    public static MessageEmbed buildEmbed(String title, String desc, Color col3, String author, String footer, EmbedField[] fields) {
        return getEmbedBuilder(title, desc, col3, author, footer, fields).build();
    }
    public static Message buildMessage(String title, String desc, Color col3, String author, String footer, EmbedField[] fields) {
        return new MessageBuilder(
                getEmbedBuilder(title, desc, col3, author, footer, fields)
        ).build();
    }


    public static MessageEmbed buildSuccessEmbed(String message) {
        // Sample green shade: 21r, 143g, 12b
        return buildEmbed("Success!", message, new Color(21,143,12), null, null, null);
    }

    public static MessageEmbed buildErrorEmbed(String message) {
        return buildEmbed("Error!", message, new Color(255,0,0), null, null, null);
    }

    public static MessageEmbed buildDevProEmbed(String title, String message) {
        // DevPro Color: 219r 120g 35b
        return buildEmbed(title, message, new Color(219,120,35), null, null, null);
    }

    public static Message buildSuccessMessage(String message) {
        // Sample green shade: 21r, 143g, 12b
        return buildMessage("Success!", message, new Color(21,143,12), null, null, null);
    }

    public static Message buildErrorMessage(String message) {
        return buildMessage("Error!", message, new Color(255,0,0), null, null, null);
    }

    public static Message buildDevProMessage(String title, String message) {
        // DevPro Color: 219r 120g 35b
        return buildMessage(title, message, new Color(219,120,35), null, null, null);
    }
}
