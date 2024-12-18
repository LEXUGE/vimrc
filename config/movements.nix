{
  keymaps = [
    # Use emacs style binding for moving to the end or front of the line.
    {
      action = "<End>";
      key = "<C-e>";
      mode = [
        "n"
        "v"
      ];
    }

    {
      action = "0";
      key = "<C-a>";
      mode = [
        "n"
        "v"
      ];
    }

    # Simplify the window movement.
    {
      action = "<C-w><C-h>";
      key = "<C-h>";
      mode = "n";
    }
    {
      action = "<C-w><C-l>";
      key = "<C-l>";
      mode = "n";
    }
    {
      action = "<C-w><C-j>";
      key = "<C-j>";
      mode = "n";
    }
    {
      action = "<C-w><C-k>";
      key = "<C-k>";
      mode = "n";
    }
  ];
}
