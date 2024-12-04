{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.samsung-unified-linux-driver];
    cups-pdf.enable = true;
  };
}
