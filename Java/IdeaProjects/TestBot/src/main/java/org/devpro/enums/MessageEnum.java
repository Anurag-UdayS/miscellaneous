package org.devpro.enums;

public enum MessageEnum {
    CHANNEL_RESERVED_SUCCESS (":tada: **Successfully reserved channel!** \n:memo: **Please fill in all your post details in:** %s."),
    CHANNEL_RESERVED_FAILURE ("**Another channel is already reserved. \n Please unreserve %s to continue.**");

    private String msg;

    MessageEnum(String msg) {this.msg = msg;}

    public static String get(MessageEnum e, String... formatElements) {
        return String.format(e.msg, (Object[]) formatElements);
    }

}
