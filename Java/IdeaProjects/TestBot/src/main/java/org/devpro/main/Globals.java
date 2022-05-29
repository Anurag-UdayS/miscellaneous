package org.devpro.main;

import net.dv8tion.jda.api.Permission;

import java.util.HashMap;

public class Globals {
    public static long GUILD_ID = 944294864735060039l;

    public static class Init {
        public static final String[] PRIVATE_CATEGORIES = {
                "Create Post: Hiring",
                "Create Post: For Hire",
                "Create Post: Collaboration Unpaid",
                "Create Post: Investor"
        };

        public static final String[] PUBLIC_CATEGORIES = {
                "Hiring Developers",
                "Developers For Hire",
                "Unpaid Collaborations",
                "Investors"
        };


        public static final HashMap<String, String[]> CHANNELS = new HashMap<>() {{
           put("Hiring Developers", new String[] {
                   "project-hiring",
                   "scripter-hiring",
                   "builder-hiring",
                   "modeler-hiring",
                   "artist-hiring",
                   "musician-hiring",
                   "programmer-hiring",
                   "clothing-designer-hiring",
                   "ui-hiring",
                   "misc-hiring"
           });

            put("Developers For Hire", new String[] {
                    "project-for-hire",
                    "scripter-for-hire",
                    "builder-for-hire",
                    "modeler-for-hire",
                    "artist-for-hire",
                    "musician-for-hire",
                    "programmer-for-hire",
                    "clothing-designer-for-hire",
                    "ui-for-hire",
                    "misc-for-hire"
            });

            put("Unpaid Collaborations", new String[] {"unpaid-collaborations"});
            put("Investors", new String[] {"investors", "looking-for-investors"});
        }};
    }

    public static class Permissions {
        public static long READ_WRITE = Permission.getRaw(
                Permission.VIEW_CHANNEL,
                Permission.MESSAGE_SEND,
                Permission.MESSAGE_EMBED_LINKS,
                Permission.MESSAGE_ATTACH_FILES,
                Permission.MESSAGE_HISTORY,
                Permission.MESSAGE_ADD_REACTION,
                Permission.USE_APPLICATION_COMMANDS
        );

        public static long READ_ONLY = Permission.getRaw(
                Permission.VIEW_CHANNEL,
                Permission.MESSAGE_HISTORY,
                Permission.MESSAGE_ADD_REACTION
        );

        public static long WRITE = Permission.getRaw(
                Permission.MESSAGE_SEND,
                Permission.MESSAGE_EMBED_LINKS,
                Permission.MESSAGE_ATTACH_FILES,
                Permission.USE_APPLICATION_COMMANDS
        );
    }
}
