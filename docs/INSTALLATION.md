# Instalação — LASC OS Foundation 1.5.0

Este documento descreve os métodos de instalação e validação disponíveis
na Foundation **1.5.0-dev** do LASC OS.

A Foundation ainda é uma versão de desenvolvimento.

O LASC OS é construído sobre o ecossistema Alpine Linux/postmarketOS.
A preparação do sistema-base e a instalação dos componentes LASC são
etapas distintas.

---

## Métodos disponíveis

Atualmente existem dois fluxos técnicos:

1. instalação de desenvolvimento a partir do código-fonte;
2. empacotamento Alpine através do `APKBUILD`.

Os APKs gerados pela CI são usados para validar construção, instalação e
conteúdo do pacote.

Ainda não existe nesta etapa um repositório APK público oficial com chave
de assinatura permanente.

---

## Requisitos para instalação do LASC OS

Para uma instalação real dos componentes LASC são necessários:

- Alpine Linux ou postmarketOS;
- utilitário `apk`;
- shell POSIX;
- privilégios administrativos;
- repositório do LASC OS disponível localmente.

A versão atual contém:

- 17 comandos `lasc-*`;
- 3 bibliotecas compartilhadas;
- arquivos de versão e changelog;
- documentação e licença.

---

## Preparação do sistema-base

O LASC OS não substitui o processo de instalação do Alpine Linux ou do
postmarketOS.

Quando postmarketOS for utilizado, o `pmbootstrap` pertence à etapa de
preparação do sistema-base.

A configuração de dispositivos, criação de imagens, gravação em mídia e
flash de hardware devem seguir a documentação do próprio postmarketOS.

A Foundation 1.5.0 não considera suporte a hardware específico concluído
apenas pela existência de uma configuração no `pmbootstrap`.

---

## Instalação de desenvolvimento

Clone o repositório:

~~~sh
git clone https://github.com/lalberto1985/lasc-os.git
cd lasc-os
~~~

Confirme a versão do código:

~~~sh
cat VERSION
~~~

A versão em desenvolvimento deve ser identificada atualmente como:

~~~text
1.5.0-dev
~~~

### Executar o instalador

O script deve ser executado com privilégios administrativos no sistema
Alpine/postmarketOS de destino.

Exemplo com `sudo`, quando disponível:

~~~sh
sudo ./scripts/install.sh
~~~

Em ambientes que utilizem outro mecanismo de elevação de privilégio,
execute o mesmo script como usuário root.

O instalador utiliza o mesmo layout de runtime definido pelo pacote APK:

~~~text
/usr/bin/lasc-*
/usr/lib/lasc-os/
/usr/share/lasc-os/
/usr/share/doc/lasc-os/
/usr/share/licenses/lasc-os/
~~~

O instalador não restaura backups históricos, não extrai tarballs em `/`
e não instala os comandos em `/usr/local/bin`.

---

## Validação após a instalação

Consulte a versão:

~~~sh
lasc-version
~~~

Execute o diagnóstico:

~~~sh
lasc-doctor
~~~

Consulte a central de ajuda:

~~~sh
lasc-help
~~~

A Foundation atual possui 17 comandos.

Para listar os comandos instalados:

~~~sh
ls -1 /usr/bin/lasc-*
~~~

Para verificar as bibliotecas:

~~~sh
ls -1 /usr/lib/lasc-os/
~~~

---

## Teste isolado com DESTDIR

Para validar o instalador sem escrever no `/usr` real, utilize um caminho
absoluto em `DESTDIR`.

Exemplo:

~~~sh
rm -rf /tmp/lasc-root

DESTDIR=/tmp/lasc-root ./scripts/install.sh
~~~

Os arquivos serão criados em:

~~~text
/tmp/lasc-root/usr/bin/
/tmp/lasc-root/usr/lib/lasc-os/
/tmp/lasc-root/usr/share/lasc-os/
/tmp/lasc-root/usr/share/doc/lasc-os/
/tmp/lasc-root/usr/share/licenses/lasc-os/
~~~

Confira a quantidade de comandos:

~~~sh
find /tmp/lasc-root/usr/bin \
    -maxdepth 1 \
    -type f \
    -name 'lasc-*' |
    wc -l
~~~

O resultado esperado para a Foundation atual é:

~~~text
17
~~~

Confira as bibliotecas:

~~~sh
find /tmp/lasc-root/usr/lib/lasc-os \
    -maxdepth 1 \
    -type f \
    -name '*.sh' |
    wc -l
~~~

O resultado esperado é:

~~~text
3
~~~

Ao terminar o teste:

~~~sh
rm -rf /tmp/lasc-root
~~~

---

## Empacotamento Alpine

A definição do pacote está em:

~~~text
packaging/alpine/APKBUILD
~~~

O processo atual produz dois pacotes:

~~~text
lasc-os
lasc-os-doc
~~~

### Pacote principal

O pacote `lasc-os` contém os componentes necessários em runtime:

~~~text
/usr/bin/lasc-*
/usr/lib/lasc-os/
/usr/share/lasc-os/VERSION
/usr/share/lasc-os/CHANGELOG.md
~~~

### Documentação

O subpacote `lasc-os-doc` contém:

~~~text
/usr/share/doc/lasc-os/README.md
/usr/share/licenses/lasc-os/LICENSE
~~~

O empacotamento é validado automaticamente em Alpine Linux pela CI.

---

## APKs gerados pela CI

A workflow de build:

- valida o `APKBUILD`;
- executa os testes da Foundation;
- constrói os pacotes;
- instala o pacote principal em um ambiente Alpine isolado;
- verifica os comandos instalados;
- publica os APKs como artifact da execução.

Esses artifacts são destinados atualmente à validação técnica do
processo de empacotamento.

Eles ainda não representam um canal público permanente de distribuição.

Não existe nesta etapa:

- repositório APK público oficial;
- chave permanente de assinatura para distribuição;
- atualização OTA do LASC OS;
- canal estável de releases para dispositivos.

Esses itens pertencem a etapas posteriores do projeto.

---

## Executar os testes da Foundation

No diretório raiz do repositório:

~~~sh
./tests/test-foundation.sh
~~~

A suíte verifica atualmente:

1. estrutura do projeto;
2. bibliotecas compartilhadas;
3. sintaxe POSIX shell;
4. padrões legados ou perigosos;
5. metadados e ajuda;
6. operações seguras;
7. instalador de desenvolvimento;
8. menus e cancelamento.

Uma execução válida termina com:

~~~text
✓ Foundation tests: OK
~~~

---

## Problemas básicos

### `apk` não encontrado

O instalador real exige Alpine Linux ou postmarketOS.

Confira:

~~~sh
command -v apk
cat /etc/os-release
~~~

O `DESTDIR` pode ser utilizado em outro ambiente apenas para testar o
layout de instalação.

### Permissão negada

Para uma instalação real, execute o script com privilégios
administrativos.

Exemplo, quando `sudo` estiver disponível:

~~~sh
sudo ./scripts/install.sh
~~~

### Comando LASC não encontrado após a instalação

Confira os arquivos instalados:

~~~sh
ls -l /usr/bin/lasc-*
~~~

Depois execute:

~~~sh
lasc-version
lasc-doctor
~~~

Não é necessário recarregar `.profile`, pois os comandos atuais são
instalados diretamente em `/usr/bin`.

### Biblioteca LASC não encontrada

Confira:

~~~sh
ls -l /usr/lib/lasc-os/
~~~

A Foundation atual espera:

~~~text
version.sh
system.sh
privilege.sh
~~~

---

## Limitações da Foundation 1.5.0

A versão **1.5.0-dev** concentra-se na fundação técnica.

Nesta etapa, a existência do código ou de referências históricas no
projeto não significa que estejam concluídos ou oficialmente suportados:

- validação em hardware real ainda é uma etapa posterior;
- suporte específico a dispositivos ainda precisa ser validado;
- integração com Waydroid não faz parte da Foundation atual;
- distribuição através de repositório APK público ainda não foi
  implementada;
- atualizações OTA ainda não fazem parte desta etapa.

---

## Documentação relacionada

- [README](../README.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Roadmap](ROADMAP.md)
- [Changelog](CHANGELOG.md)
- [Contribuição](CONTRIBUTING.md)

---

## Licença

Os componentes próprios do LASC OS são distribuídos sob a licença MIT.

Alpine Linux, postmarketOS e demais componentes externos mantêm suas
respectivas licenças.

---

**LASC OS — Privacidade • Liberdade • Controle**
