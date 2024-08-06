# lit-graph

This project uses SOPS for secrets management, using [age](https://github.com/FiloSottile/age) encryption. Contact the project owner for the decryption key.

## Dependencies
| Dependency                                | Version  |
| ----------------------------------------- | -------- |
| [age](https://github.com/FiloSottile/age) | >= 1.0.0 |
| [SOPS](https://github.com/getsops/sops)   | >= 3.9   |

## Development Setup
### SOPS Setup
1. Install [age](https://github.com/FiloSottile/age) and [SOPS](https://github.com/getsops/sops/releases).
   - If you're on VS Code, you can install the [SOPS extension](https://marketplace.visualstudio.com/items?itemName=ShipitSmarter.sops-edit) for easier editing.
2. Run `./scripts/age_setup.sh`, which will generate a new keypair. Take note of the public key, as you will need to provide it to the project owner to decrypt secrets.

