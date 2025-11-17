{
  users = {
    snock = {
      name = "snock";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvwpMNCPRDapiEGHKpvCpQvrDPtQMbAONFB/J7MEoPO";
    };
    agent = {
      name = "agent";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFqVB+MuXOi0nZZ8s3RBgIKkHiRHtyro2h0DKl96y4YD";
    };
    coworker = {
      name = "coworker";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFqVB+MuXOi0nZZ8s3RBgIKkHiRHtyro2h0DKl96y4YD";
    };
    machine = {
      name = "machine";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKvwpMNCPRDapiEGHKpvCpQvrDPtQMbAONFB/J7MEoPO";
    };
  };

  machines = {
    macbook_air = {
      name = "macbook_air";
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMxWFonAqQYCE8ilpF0atqKhVWpAYOOfJIkBF7DZgaGYcP3sOa2oXo592gZ30GJPcTosqibdAHW/SWt8Ob/eGmookHZh+CrxXkFDVqgIFUkeZL074ySPTPnOD1odF/aP5TQqV9ZmHBjN0ngNo0SGSWzai9TRnqsAkcaynTu1htUSEBqHq1vgyPTSQh+fHn+maHKVskz7AH6zeyixFxQkGwfMGn1PgN/cdElFBFgcdFpbfRzjKbRPOJDRtVDbgZqz7Ni0kFmJaellKrCM4LU/TjoS0M7iBah+PI43JjOQERV9lLguzrUrO7KTGd2NY0EWIJi8JkXNTAG9BxZFBYZuwXX6SExbVhM3IYliI4zyKFwS1kiLupStL7qv6Lhlfv76Kq2uUcPzsnvZmCrvpU0rYJXgNs+v6EUbXhwPQZvvtKaUvd37gBOyiK8bwn+fmC8yYJT+AaY73sEwTdirIcgOXEhkZYXkme9xEtEKD+w0z9tFNrIkF2sFqxKchtQNPtSVM= nilsriedemann@Nilss-Air.fritz.box";
    };
    coworker = {
      name = "coworker";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIwoAybAtrKLOyFrInLOecMEtm9htJ8U1P3b2seJG7r6";
    };
    repo = {
      name = "repo";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwjFZj/6DTDPBo2RX3rPpe/bjteAewdLncF1EXrSIwO";
    };
    studio = {
      name = "studio";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKaqQdiYDP+sAs4OiGNua2P9bYAnYVkzEFRDzvBLEFig";
    };
    preview = {
      name = "preview";
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINX9OJzgGJAJeljdVTVtI3bsevFH9cCs93CMvcmIlT0q";
    };
  };
}
