# LASC OS — Troubleshooting

Guia de diagnóstico e solução de problemas da Foundation **1.5.0**.

Este documento cobre somente comportamentos e componentes presentes na
Foundation atual.

---

## Sumário

- [Instalação](#instalação)
- [Comandos não encontrados](#comandos-não-encontrados)
- [Diagnóstico geral](#diagnóstico-geral)
- [Rede](#rede)
- [Logs](#logs)
- [Espaço em disco](#espaço-em-disco)
- [Bibliotecas](#bibliotecas)
- [Pacotes APK](#pacotes-apk)
- [Limitações da Foundation](#limitações-da-foundation)
- [Suporte](#suporte)

---

## Instalação

### "A instalação de sistema requer Alpine Linux ou postmarketOS"

O instalador real verifica a existência do utilitário `apk`.

Confirme o ambiente:

~~~sh
cat /etc/os-release
command -v apk
~~~

A instalação real dos componentes LASC é destinada a Alpine Linux ou
postmarketOS.

Em outro sistema, utilize `DESTDIR` somente para validar o layout:

~~~sh
DESTDIR=/tmp/lasc-root ./scripts/install.sh
~~~

---

### Instalação exige privilégios administrativos

Para escrever em `/usr`, o instalador precisa ser executado como root.

Quando `sudo` estiver disponível:

~~~sh
sudo ./scripts/install.sh
~~~

O instalador atual não extrai backups ou tarballs históricos.

---

### Testar o instalador sem modificar o sistema

Utilize:

~~~sh
rm -rf /tmp/lasc-root
DESTDIR=/tmp/lasc-root ./scripts/install.sh
~~~

Confira:

~~~sh
find /tmp/lasc-root/usr/bin -maxdepth 1 -name 'lasc-*' -type f | wc -l
find /tmp/lasc-root/usr/lib/lasc-os -maxdepth 1 -name '*.sh' -type f | wc -l
~~~

A Foundation atual espera:

~~~text
17 comandos
3 bibliotecas
~~~

Depois:

~~~sh
rm -rf /tmp/lasc-root
~~~

---

## Comandos não encontrados

### `lasc-dashboard: command not found`

Os comandos atuais são instalados diretamente em:

~~~text
/usr/bin/
~~~

Confira:

~~~sh
ls -l /usr/bin/lasc-*
~~~

Não é necessário executar `source ~/.profile`.

Se os arquivos não estiverem presentes, reinstale a partir do
repositório:

~~~sh
sudo ./scripts/install.sh
~~~

Depois execute:

~~~sh
lasc-version
lasc-doctor
~~~

---

## Diagnóstico geral

O primeiro comando para investigar problemas deve ser:

~~~sh
lasc-doctor
~~~

O diagnóstico atual verifica:

- espaço em disco;
- uso de memória;
- presença dos 17 comandos LASC;
- aplicativos opcionais conhecidos.

Aplicativos opcionais ausentes são tratados como avisos e não significam
necessariamente que a Foundation esteja quebrada.

Para consultar a versão:

~~~sh
lasc-version
~~~

Para consultar os comandos disponíveis:

~~~sh
lasc-help
~~~

---

## Rede

Use:

~~~sh
lasc-network
~~~

O comando apresenta:

- interfaces detectadas;
- estado das interfaces;
- endereço IPv4;
- interface padrão;
- gateway;
- servidor DNS;
- conectividade;
- latência quando disponível;
- bytes recebidos e enviados.

### Interface não detectada

Confira diretamente:

~~~sh
ip link show
~~~

E a rota padrão:

~~~sh
ip route
~~~

### IP não detectado

Confira:

~~~sh
ip -4 addr
~~~

### Gateway não detectado

Confira:

~~~sh
ip route
~~~

Procure uma linha iniciada por:

~~~text
default
~~~

### DNS não detectado

Confira:

~~~sh
cat /etc/resolv.conf
~~~

### `lasc-network` mostra "Offline ou ICMP indisponível"

O teste atual utiliza `ping`.

Confira:

~~~sh
command -v ping
ping -c 3 8.8.8.8
~~~

Falha nesse teste pode significar:

- ausência de conectividade;
- bloqueio de ICMP;
- problema de rota;
- ausência do utilitário `ping`.

Não significa automaticamente que a interface de rede esteja desligada.

---

## Logs

Para visualizar os logs recentes:

~~~sh
lasc-log
~~~

O comando utiliza a primeira fonte disponível:

1. `journalctl`;
2. `dmesg`.

### Nenhuma fonte de logs disponível

Confira:

~~~sh
command -v journalctl
command -v dmesg
~~~

Nem todo ambiente Alpine/postmarketOS utiliza `systemd`, portanto a
ausência de `journalctl` não significa necessariamente um problema no
LASC OS.

Se `dmesg` existir mas não puder ser lido, verifique as permissões do
ambiente.

---

## Espaço em disco

O `lasc-doctor` considera uso elevado do disco um problema de diagnóstico.

Confira diretamente:

~~~sh
df -h /
~~~

Antes de executar qualquer limpeza, faça uma simulação:

~~~sh
lasc-clean --dry-run
~~~

Esse modo não altera o sistema.

Se a simulação estiver correta, execute:

~~~sh
lasc-clean
~~~

A limpeza atual pode tratar:

- cache de pacotes APK;
- arquivos temporários `/tmp/lasc-*` e `/tmp/LASC-*`;
- logs antigos do journal, quando `journalctl` estiver disponível.

A disponibilidade de cada operação depende do sistema.

---

## Bibliotecas

Os comandos compartilhados da Foundation utilizam bibliotecas instaladas
em:

~~~text
/usr/lib/lasc-os/
~~~

A instalação atual espera:

~~~text
version.sh
system.sh
privilege.sh
~~~

Confira:

~~~sh
ls -l /usr/lib/lasc-os/
~~~

Se uma biblioteca estiver ausente, valide também os comandos:

~~~sh
ls -l /usr/bin/lasc-*
~~~

Em uma instalação incompleta, reinstale os componentes a partir da árvore
de código:

~~~sh
sudo ./scripts/install.sh
~~~

Depois execute:

~~~sh
lasc-version
lasc-doctor
~~~

---

## Pacotes APK

O empacotamento da Foundation produz:

~~~text
lasc-os
lasc-os-doc
~~~

O pacote principal contém o runtime e o subpacote `lasc-os-doc` contém
README e licença.

### Build APK falhou na CI

A definição está em:

~~~text
packaging/alpine/APKBUILD
~~~

Execute primeiro os testes locais:

~~~sh
./tests/test-foundation.sh
~~~

E valide alterações de whitespace no Git:

~~~sh
git diff --check
~~~

O build APK completo é validado em Alpine pela workflow do projeto.

### Artifact da CI

Os APKs publicados pelas execuções da CI são artifacts de validação.

Nesta etapa eles não constituem um repositório público oficial de
pacotes.

A infraestrutura atual ainda não possui:

- repositório APK público permanente;
- chave de assinatura permanente destinada à distribuição;
- canal estável de atualização.

Por isso, não trate um artifact isolado da CI como mecanismo oficial de
instalação em produção.

---

## Problemas com aplicativos opcionais

O `lasc-doctor` também verifica alguns aplicativos opcionais.

A ausência de um aplicativo opcional é apresentada como aviso, não como
falha crítica da Foundation.

Para verificar os pacotes disponíveis no sistema, utilize as ferramentas
do Alpine/postmarketOS apropriadas ao ambiente.

---

## Limitações da Foundation

A Foundation **1.5.0** concentra-se em estrutura, runtime,
empacotamento, instalação e testes.

Nesta etapa não devem ser considerados recursos concluídos apenas por
existirem referências históricas no repositório.

Ainda pertencem a etapas posteriores:

- validação em hardware real;
- suporte oficial a dispositivos específicos;
- integração com Waydroid;
- repositório público de pacotes;
- assinatura permanente de distribuição;
- atualizações OTA;
- funcionalidades mobile específicas que não estejam entre os 17
  comandos atuais.

Comandos históricos como `lasc-wifi`, `lasc-battery`,
`lasc-brightness`, `lasc-theme`, `lasc-quote` e `lasc-ascii` não fazem
parte da Foundation atual.

---

## Suporte

Antes de registrar um problema, obtenha:

~~~sh
lasc-version
lasc-doctor
lasc-network
~~~

Quando o problema envolver logs:

~~~sh
lasc-log
~~~

Ao abrir uma issue, informe:

- mensagem de erro completa;
- saída relevante do `lasc-doctor`;
- versão retornada por `lasc-version`;
- sistema-base e versão;
- tipo de ambiente utilizado;
- passos necessários para reproduzir o problema.

Issues do projeto:

https://github.com/lalberto1985/lasc-os/issues

---

## Documentação relacionada

- [README](../README.md)
- [Instalação](INSTALLATION.md)
- [Roadmap](ROADMAP.md)
- [Changelog](CHANGELOG.md)

---

**LASC OS — Privacidade • Liberdade • Controle**
