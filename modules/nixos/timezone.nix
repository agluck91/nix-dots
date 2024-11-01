{...}: let
  encoding = "en_US.UTF-8";
in {
  # Set your time zone.
  time.timeZone = "America/Kentucky/Louisville";

  # Select internationalisation properties.
  i18n.defaultLocale = encoding;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = encoding;
    LC_IDENTIFICATION = encoding;
    LC_MEASUREMENT = encoding;
    LC_MONETARY = encoding;
    LC_NAME = encoding;
    LC_NUMERIC = encoding;
    LC_PAPER = encoding;
    LC_TELEPHONE = encoding;
    LC_TIME = encoding;
  };
}
