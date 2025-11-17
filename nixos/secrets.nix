let
  keys = import globals/keys.nix;

  everyone = [
    keys.users.snock.publicKey
    keys.users.agent.publicKey
  ];

  everywhere = [
    keys.machines.coworker.publicKey
    keys.machines.repo.publicKey
    keys.machines.macbook_air.publicKey
  ];

  all = everyone ++ everywhere;
in {
  "users/agent.sshKey.age".publicKeys = all;
  "users/agent.ghToken.age".publicKeys = all;
  "users/agent.anthropicApiKey.age".publicKeys = all;
  "globals/tailscaleAuthKey.age".publicKeys = all;
  "machines/repo/gitlab-db-password.age".publicKeys = all;
  "machines/repo/gitlab-root-password.age".publicKeys = all;
  "machines/repo/gitlab-secret.age".publicKeys = all;
  "machines/repo/gitlab-otp.age".publicKeys = all;
  "machines/repo/gitlab-db-secret.age".publicKeys = all;
  "machines/repo/gitlab-jws.age".publicKeys = all;
  "machines/repo/gitlab-ar-primary-key.age".publicKeys = all;
  "machines/repo/gitlab-ar-deterministic-key.age".publicKeys = all;
  "machines/repo/gitlab-ar-salt.age".publicKeys = all;
}
