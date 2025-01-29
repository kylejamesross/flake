{config, ...}: {
  services = {
    ollama = {
      enable = config.ollama.enable;
      acceleration = "rocm";
      loadModels = [
        "deepseek-r1:1.5b"
      ];
    };
  };
}
