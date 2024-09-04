# Changelog

## [3.8.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.7.0...v3.8.0) (2024-09-04)


### Features

* move recurring jobs to their own resources ([4a441d2](https://github.com/camptocamp/devops-stack-module-longhorn/commit/4a441d2a659d37d7ad695370152d28153e798226))


### Bug Fixes

* remove attribute causing issues when bootstrapping cluster ([57c311d](https://github.com/camptocamp/devops-stack-module-longhorn/commit/57c311d960a04fe8c460b69c7cc42bd62a410906))

## [3.7.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.6.0...v3.7.0) (2024-08-20)


### Features

* **chart:** minor update of dependencies on longhorn chart ([#37](https://github.com/camptocamp/devops-stack-module-longhorn/issues/37)) ([83c1de8](https://github.com/camptocamp/devops-stack-module-longhorn/commit/83c1de8a3050fac269e98aac244f1544dfa2a178))

## [3.6.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.5.0...v3.6.0) (2024-06-18)


### Features

* **chart:** patch update of dependencies on longhorn chart ([#33](https://github.com/camptocamp/devops-stack-module-longhorn/issues/33)) ([b14477e](https://github.com/camptocamp/devops-stack-module-longhorn/commit/b14477efdd759db69609420ef271f105277f4140))

## [3.5.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.4.0...v3.5.0) (2024-04-16)


### Features

* upgrade OAuth Proxy image version ([6e6ce6f](https://github.com/camptocamp/devops-stack-module-longhorn/commit/6e6ce6fa0675fdda3b730fc40f32e3e865de2050))


### Bug Fixes

* fix upgrade check which was broken by the chart v1.6.0 ([72d6223](https://github.com/camptocamp/devops-stack-module-longhorn/commit/72d62232b4055eb54ba80aec16b813d6f24a55da))

## [3.4.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.3.1...v3.4.0) (2024-03-01)


### Features

* **chart:** minor update of dependencies on longhorn chart ([#28](https://github.com/camptocamp/devops-stack-module-longhorn/issues/28)) ([32b3a96](https://github.com/camptocamp/devops-stack-module-longhorn/commit/32b3a9620abf9793b4c034a6daa9629c7ef3f1cc))

## [3.3.1](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.3.0...v3.3.1) (2024-03-01)


### Bug Fixes

* remove legacy ingress annotations ([c1613f6](https://github.com/camptocamp/devops-stack-module-longhorn/commit/c1613f6a03f160ac13b6962b351622f328709cd7))

## [3.3.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.2.1...v3.3.0) (2024-02-23)


### Features

* add a subdomain variable ([0515a54](https://github.com/camptocamp/devops-stack-module-longhorn/commit/0515a5495cf7bb4e412d7ffc68dd23789711c6fd))


### Bug Fixes

* make subdomain variable non-nullable ([9e98d8c](https://github.com/camptocamp/devops-stack-module-longhorn/commit/9e98d8c350ae29d38880f268aaae7c892a9d9490))
* remove annotation for the redirection middleware ([a1ed297](https://github.com/camptocamp/devops-stack-module-longhorn/commit/a1ed2978e6bddf3adf0c51c56da176c44d3297a6))

## [3.2.1](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.2.0...v3.2.1) (2024-01-26)


### Bug Fixes

* conditional issue with persistence defaultClass helm variable ([#25](https://github.com/camptocamp/devops-stack-module-longhorn/issues/25)) ([f879d01](https://github.com/camptocamp/devops-stack-module-longhorn/commit/f879d016831f21fe7665c34ecccb2f7939959338))

## [3.2.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.1.0...v3.2.0) (2024-01-26)


### Features

* add automatic filesystem trim feature using recurringjob ([8c3647c](https://github.com/camptocamp/devops-stack-module-longhorn/commit/8c3647cbe6c285ccfee8ab96b0681da9ae7b7102))
* add variable for additional alerts labels ([9dbf9aa](https://github.com/camptocamp/devops-stack-module-longhorn/commit/9dbf9aafbf571198a8c6e98cb5a6b482c9603093))

## [3.1.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v3.0.0...v3.1.0) (2024-01-25)


### Features

* **chart:** minor update of dependencies on longhorn chart ([#12](https://github.com/camptocamp/devops-stack-module-longhorn/issues/12)) ([d26a8fd](https://github.com/camptocamp/devops-stack-module-longhorn/commit/d26a8fdd3f1cc3a55d7982d523e52ce6929fd29b))

## [3.0.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v2.3.0...v3.0.0) (2024-01-19)


### ⚠ BREAKING CHANGES

* hardcode the release name to remove the destination cluster
* remove the ArgoCD namespace variable
* remove the namespace variable

### Bug Fixes

* change the default cluster issuer ([c09df57](https://github.com/camptocamp/devops-stack-module-longhorn/commit/c09df5777c5f857fcc91f9cb1c0276f2a5a14718))
* hardcode the release name to remove the destination cluster ([1759d38](https://github.com/camptocamp/devops-stack-module-longhorn/commit/1759d38d231a17177d24d3814be91aa9cb650949))
* remove the ArgoCD namespace variable ([2893a68](https://github.com/camptocamp/devops-stack-module-longhorn/commit/2893a682d2942cba53f630c8db8dee26abbe2262))
* remove the namespace variable ([841175e](https://github.com/camptocamp/devops-stack-module-longhorn/commit/841175e4a78fc2db9ebf0638d0d71f8a2f10dc7f))

## [2.3.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v2.2.0...v2.3.0) (2023-10-19)


### Features

* add standard variables and variable to add labels to Argo CD app ([8ec1b98](https://github.com/camptocamp/devops-stack-module-longhorn/commit/8ec1b9855973a15651ddefa6f31d1453a943e791))
* add variables to set AppProject and destination cluster ([74d6627](https://github.com/camptocamp/devops-stack-module-longhorn/commit/74d662701c6c1df3dfb94108c44c3a7ff0671663))
* update OAuth2-Proxy version ([a817040](https://github.com/camptocamp/devops-stack-module-longhorn/commit/a8170407ee7fb94a4aec018ae51397ce00127f36))

## [2.2.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v2.1.1...v2.2.0) (2023-08-23)


### Features

* parameterize backup and replicas settings and tweak default values ([9ba0c11](https://github.com/camptocamp/devops-stack-module-longhorn/commit/9ba0c115521edda46e82a11138bc0fc56cfafa0a))

## [2.1.1](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v2.1.0...v2.1.1) (2023-08-09)


### Bug Fixes

* readd support to deactivate auto-sync which was broken by [#6](https://github.com/camptocamp/devops-stack-module-longhorn/issues/6) ([8e26944](https://github.com/camptocamp/devops-stack-module-longhorn/commit/8e2694417da0c30881f8a4a0a5759cb56f5c664c))

## [2.1.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v2.0.0...v2.1.0) (2023-07-19)


### Features

* add toleration variable to deploy Longhorn on tainted nodes ([#8](https://github.com/camptocamp/devops-stack-module-longhorn/issues/8)) ([d8f458c](https://github.com/camptocamp/devops-stack-module-longhorn/commit/d8f458c9882fb1166fbc953aff8973fdd437d49e))

## [2.0.0](https://github.com/camptocamp/devops-stack-module-longhorn/compare/v1.0.0...v2.0.0) (2023-07-11)


### ⚠ BREAKING CHANGES

* add support to oboukili/argocd v5 ([#6](https://github.com/camptocamp/devops-stack-module-longhorn/issues/6))

### Features

* add support to oboukili/argocd v5 ([#6](https://github.com/camptocamp/devops-stack-module-longhorn/issues/6)) ([a1d25e5](https://github.com/camptocamp/devops-stack-module-longhorn/commit/a1d25e55a2bca0cb0eb67e41716e6c1dffe592ac))

## 1.0.0 (2023-06-28)


### Features

* initial module implementation ([#1](https://github.com/camptocamp/devops-stack-module-longhorn/issues/1)) ([99d1afb](https://github.com/camptocamp/devops-stack-module-longhorn/commit/99d1afb01f6a2800c7255541cacaac90c55a98bf))
