## Instalação do OpenWRT no roteador Acer Predator W6x - Problemas Gerais e Troubleshooting

#### Idioma: _Português BR_
### Esse repositório mostra alguns problemas que enfrentei para instalar o sistema operacional openWRT no roteador Acer Predator W6x. Não encontrei nenhum documento, fórum, artefato, vídeo ou pesquisa na internet que me ajudasse quando eu fui fazer essa instalação além da página oficial da openWRT, por isso criei esse repositório.
 # 1- "Mas o guia oficial do OpenWRT não ensina tudo que é necessário?" </br>
 Não, ele pode te ajudar muito, mas só cobre o básico. Além de que existem vários lotes de fabricação e cada modelo é diferente. Aqui neste passo a passo tentarei ajudar com o máximo de informações para essa instalação.
# 2- Este não é um guia de instalação oficial, é apenas a MINHA experiência sendo compartilhada.
# 3- Pessoalmente recomendo pedir para sua IA de preferência fazer um resumo do repositório, sem pular nenhuma informação, pois é bastante conteúdo e vai te poupar tempo.

# OpenWrt no Acer Predator Connect W6x
### Instalação completa via Serial + U-Boot + TFTP (Guia real com erros e soluções)

---

## 📌 Visão Geral

Este repositório documenta a minha instalação completa do **OpenWrt no Acer Predator Connect W6x**, partindo do zero absoluto.

O objetivo não é apenas ajudar no processo, mas também mostrar os **problemas reais enfrentados** e como resolvê-los.

> Este projeto representa a **Etapa 0 do meu homelab de cibersegurança**.

---

## ⚠️ Avisos Importantes

- Este processo envolve acesso físico ao roteador. 
- Existe risco de brick.
- Você é responsável pelo seu equipamento, eu não tenho nada haver com seus erros.
- Sempre siga a documentação oficial.  

🔗 https://openwrt.org/toh/acer/predator_connect_w6x

---

## 🧠 Contexto

O início com OpenWrt pode ser confuso quando:

- O dispositivo não tem recovery via interface web  
- A documentação assume conhecimento prévio  
- Existem variações de hardware  

Neste guia busco resolver exatamente esses pontos.

---

## PRIMEIRO PASSO GERAL - Identificação de Lote
- Com o roteador desconectado da energia ou lan/wan, abra a sua tampa superior pressionando a parte maior que fica atrás dele, para cima. A tampa do roteador é de encaixe, então basta desencaixar. Mas é bem pesadinho, então preste atenção para não quebrar o roteador no processo.
<img src="https://github.com/daabarbacena/OpenWRT-w6x-router/blob/main/images/roteador-demo.png" alt="Demonstrativo-tampa" width="600">
- Identifique o tipo de UART (É uma parte do roteador que transmite sinal via Serial) do roteador. Pode ser de pads (essas superfícies prateadas na segunda imagem) igual o meu, ou pode vir pinos, igual o da referência do site da OpenWRT.
<img src="https://openwrt.org/_media/media/acer/acer-predator-connect-w6x-uart-pins.jpg?w=400&tok=021209" alt="UART com pino" width="600">
<img src="https://github.com/daabarbacena/OpenWRT-w6x-router/blob/main/images/w6x-interno.jpeg" alt="Demonstrativo-tampa" width="600">

- Guarde essa informação para o seguinte passo.

## 📦 Materiais Utilizados

### Hardware
- Acer Predator Connect W6x  
- Adaptador USB → TTL (3.3V)
<img src="https://http2.mlstatic.com/D_NQ_NP_2X_787287-MLA99580419106_122025-F.webp" alt="Adaptador ttl" width="600">
Minha recomendação de compra (Já vem com os jumpers femea-femea):
https://s.shopee.com.br/15iud8yS6?share_channel_code=1 </br>
 
- Jumpers fêmea–fêmea  </br>
<img src="https://imgs.search.brave.com/NkqBkCMdFw1rEbdUnZeigC2JfhR7DUpNaUPiQVgxGyc/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9odHRw/Mi5tbHN0YXRpYy5j/b20vRF9RX05QXzJY/XzY2OTMxNS1NTEE5/MTYwMTQ1ODM1OF8w/OTIwMjUtRS53ZWJw" alt="Jumper f-f" width="600">
- Header macho (Caso o UART for de pad)  </br>
<img src="https://imgs.search.brave.com/-EN2g4007V9rw2XWFy6gw2S_lnFSb-bSCQ90d3Cs290/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91ZWxl/Y3Ryb25pY3MuY29t/L3dwLWNvbnRlbnQv/dXBsb2Fkcy8yMDIx/LzA4L0FSMjc0My1Q/aW4tSGVhZGVyLU1h/Y2hvLUwyMC1WMi5q/cGc" alt="Header macho" width="600"> </br>
  Esses não tem o link de compra porque qualquer um serve.  </br>
   </br>
- Ferro de solda + estanho (Caso o UART for de pad)  </br>
- Cabo Ethernet  </br>
- PC   </br>

### Software
- PuTTY  
- Tftpd64  
- OpenWrt (imagens oficiais)  

---

## ❗ Problemas Reais Encontrados (e soluções)

### 1. Roteador sem pinos TTL (apenas pads)

**Problema:**  
O roteador não vinha com header — apenas pads lisos.

**Solução:**  
- Soldar header macho manualmente  
- Usar apenas:
  - TX  
  - RX  
  - GND  

⚠️ Nunca conectar VCC  

<img src="https://github.com/daabarbacena/OpenWRT-w6x-router/blob/main/images/openWRT-setupado.jpeg" alt="Demonstrativo-tampa" width="600">

---

### 2. Confusão RS232 vs TTL

**Problema:**  
Vários adaptadores online mencionam serem RS232, mas são TTL, opte por comprar um dos dois links que citei acima.

**Solução:**  
Confirmar que é **TTL 3.3V**. Ou simplesmente comprar pelo link que recomendei. 
RS232 real pode danificar o roteador.

---

## Problema 3 — incerteza sobre como interromper o boot

### O que aconteceu

No log completo do boot, o menu do U-Boot não apareceu claramente.

Isso levou à dúvida:

- o bootloader está bloqueado?
- o menu não existe?
- o OpenWrt oficial para esse modelo depende de algo que o meu roteador não oferece?

### Confusão

A documentação oficial mostra que o método depende do U-Boot, mas na hora do "vamo ver" o boot passa muito rápido.

Então, para quem está começando, parece que o procedimento oficial é impossível.

### Solução

Foi feito um novo boot com atenção ao início da serial, até confirmar que:

- o **menu do U-Boot existia sim**;
- ele apenas ficava disponível por um tempo muito curto (0.5s~1.5s).

Quando o menu apareceu, ficou claro que o caminho oficial era viável.

---

## Problema 4 — não saber qual opção escolher no menu do U-Boot

### O menu encontrado

O U-Boot mostrou opções como:

- Startup system
- Upgrade firmware
- Upgrade ATF BL2
- Upgrade ATF FIP
- Upgrade single image
- Load image
- U-Boot console

### Por que isso confunde

Para quem está começando, várias dessas opções parecem equivalentes.

Mas não são.

Algumas mexem em partes sensíveis do boot, como:

- BL2
- FIP
- imagens individuais

Essas opções não devem ser usadas sem saber exatamente o que está sendo feito.

### Solução

Foi usada a opção correta para esse fluxo:

- **Load image**

Essa opção permite carregar a imagem do OpenWrt temporariamente em RAM, sem gravar nada ainda na flash.

Isso é muito importante porque:

- reduz risco;
- permite validar hardware e boot;
- segue o método oficial.

---

## Problema 5 — TFTP com várias perguntas e risco de erro manual

### O que aconteceu

Depois de escolher “Load image”, o U-Boot pediu várias informações:

- load address
- método de carregamento
- IP do U-Boot
- IP do servidor TFTP
- netmask
- nome do arquivo
- confirmar execução

### Por que isso confunde

Esse tipo de etapa parece simples para quem já fez isso antes, mas para iniciantes é uma sequência cheia de pontos onde um detalhe errado quebra tudo:

- IP errado
- netmask errada
- nome de arquivo digitado errado
- arquivo errado
- endereço de memória errado

### Solução

Foi usado o fluxo correto:

- endereço de carga em RAM;
- TFTP como método;
- PC como servidor TFTP;
- imagem **initramfs-kernel** correta para o W6x.

---

## Problema 6 — diferença entre initramfs e sysupgrade

### O que aconteceu

Depois de conseguir bootar o OpenWrt em RAM, surgiu a dúvida entre dois arquivos:

- `initramfs-kernel`
- `sysupgrade`

### Por que isso confunde

Os nomes parecem técnicos demais e pouco intuitivos.

Para quem está começando, a pergunta natural é:

> “Se os dois são do OpenWrt, por que não usar qualquer um?”

### Explicação simples

#### `initramfs-kernel`
É usado para **boot temporário em RAM**.

Ele serve para:

- testar;
- validar o hardware;
- entrar no sistema sem escrever na flash.

Se você desligar o roteador depois disso, tudo some.

#### `sysupgrade`
É usado para **instalação definitiva**.

Ele é o arquivo que grava o OpenWrt na memória flash do roteador.

### Solução

O fluxo correto foi:

1. Boot do `initramfs-kernel` via U-Boot + TFTP
2. Depois, já dentro do OpenWrt temporário, gravar o `squashfs-sysupgrade.bin`

---

## Problema 7 — erro no SCP: SFTP ausente

### O que aconteceu

Ao tentar copiar o arquivo de sysupgrade com `scp`, apareceu erro relacionado a:

bash
/usr/libexec/sftp-server: not found

## Por que isso confunde

A rede estava funcionando, o ping funcionava, o roteador respondia, mas a cópia falhava.

Isso dá a impressão de que:

- o SSH está quebrado;
- a rede está com problema;
- o arquivo está errado.

### Causa real

O OpenWrt temporário carregado via initramfs não tinha o componente necessário para o modo SFTP moderno que o `scp` do Windows tentou usar.

### Solução

Forçar o modo clássico do SCP:

```bash
scp -O openwrt-mediatek-filogic-acer_predator-w6x-stock-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
```

O `-O` resolveu o problema.

---

## Problema 8 — erro de chave SSH / known_hosts

### O que aconteceu

Ao tentar usar SSH/SCP, o Windows avisou que a identificação do host havia mudado.

### Por que isso confunde

A mensagem parece muito grave, como se houvesse um ataque.

### Causa real

Antes, o IP `192.168.1.1` respondia com a chave SSH do sistema anterior. Depois do boot do OpenWrt em RAM, o mesmo IP passou a responder com outra chave.

Então o aviso era legítimo, mas esperado.

### Solução

Remover a entrada antiga do `known_hosts`:

```bash
ssh-keygen -R 192.168.1.1
```

---

## Problema 9 — erro ao configurar a WAN e o firewall

### O que aconteceu

Depois da instalação, a WAN física subiu, mas ao configurar firewall manualmente surgiu erro como:

```bash
redefinition of symbol 'wan_devices'
```

### Por que isso confunde

A WAN parecia simples:

- definir `eth1`;
- usar DHCP;
- associar ao firewall.

Mas havia um detalhe importante: o OpenWrt já tinha zonas internas de firewall, e a criação manual errada de outra zona `wan` gerou conflito.

### Causa real

- zona WAN duplicada;
- configuração manual criada por cima da estrutura existente;
- typo em `forward`.

### Solução

Apagar a zona duplicada criada manualmente e usar a zona WAN real do sistema.

---

## Problema 10 — a interface web não abria, mesmo com rede funcionando

### O que aconteceu

Depois da instalação:

- o ping funcionava;
- a LAN estava correta;
- a internet já funcionava;
- mas o navegador não abria a interface web.

### Por que isso confunde

Quando a web não abre, a reação natural é pensar em:

- erro de IP;
- erro de firewall;
- erro de rede;
- instalação quebrada.

### Causa real

No build SNAPSHOT usado, o **LuCI não estava instalado por padrão**.

### Solução

Instalar LuCI manualmente depois que a WAN ficou funcional:

```bash
apk update
apk add luci
/etc/init.d/uhttpd restart
```

---

## Problema 11 — expectativa errada sobre “potência máxima” no Wi-Fi

### O que aconteceu

Depois de ativar as redes 2.4 GHz e 5 GHz, a velocidade observada no 5 GHz ficou por volta de 350 Mbps.

Isso gerou a dúvida:

- será que o OpenWrt está com potência baixa?
- será que basta aumentar `channel width` ou `channel` para “o máximo”?

### Por que isso confunde

Muita gente assume que “máximo” significa:

- mais potência;
- mais velocidade;
- melhor alcance.

Na prática, Wi-Fi não funciona assim.

### Explicação simples

A performance do Wi-Fi depende de:

- ambiente;
- interferência;
- capacidade do cliente;
- largura de canal;
- país/regulatório;
- canal escolhido;
- obstáculos;
- ruído.

Além disso:

- o OpenWrt respeita limites regulatórios;
- o driver não deixa simplesmente “forçar potência ilegal”.

### Conclusão

Em ambiente urbano, com vizinhos e interferência, 350 Mbps reais no 5 GHz não significa defeito.

---

## Estrutura geral do processo

O fluxo correto foi este:

1. Abrir o roteador
2. Soldar acesso serial
3. Conectar TTL 3.3V
4. Abrir serial no PuTTY
5. Interromper boot
6. Entrar no menu do U-Boot
7. Escolher `Load image`
8. Servir o `initramfs-kernel` via TFTP
9. Bootar o OpenWrt temporário em RAM
10. Copiar o `sysupgrade.bin` para `/tmp`
11. Executar `sysupgrade`
12. Rebootar
13. Configurar WAN
14. Instalar LuCI
15. Ativar Wi-Fi
16. Validar persistência

---

## Conexão serial TTL

### Ligações corretas

| Roteador | Adaptador USB-TTL |
|----------|-------------------|
| TX       | RX                |
| RX       | TX                |
| GND      | GND               |

### Observação

- Não usar VCC
- Certificar que o adaptador é **3.3V**

---

## Configuração da serial

Foi usado:

- **PuTTY**
- Porta COM do adaptador
- **115200**
- 8N1

Depois de ligar o roteador, o log de boot apareceu normalmente.

---

## Acesso ao U-Boot

Ao interromper o boot, apareceu o menu com a opção:

- **6 - Load image**

Essa foi a opção utilizada para seguir o fluxo oficial.

---

## Configuração do TFTP

No PC:

- IP manual: `192.168.1.2`
- Máscara: `255.255.255.0`

No Tftpd64:

- interface apontando para `192.168.1.2`
- pasta contendo a imagem initramfs

---

## Arquivo usado para boot temporário

Arquivo correto para o boot em RAM:

```text
openwrt-mediatek-filogic-acer_predator-w6x-stock-initramfs-kernel.bin
```

Esse arquivo **não instala** o sistema. Ele apenas permite inicializar o OpenWrt temporariamente.

---

## Arquivo usado para instalação definitiva

Arquivo correto para gravar na flash:

```text
openwrt-mediatek-filogic-acer_predator-w6x-stock-squashfs-sysupgrade.bin
```

Esse foi o arquivo usado para instalação permanente.

---

## Comando de cópia do firmware definitivo

```bash
scp -O openwrt-mediatek-filogic-acer_predator-w6x-stock-squashfs-sysupgrade.bin root@192.168.1.1:/tmp/
```

---

## Comando de instalação definitiva

```bash
sysupgrade /tmp/openwrt-mediatek-filogic-acer_predator-w6x-stock-squashfs-sysupgrade.bin
```

---

## Verificação de instalação persistente

Depois da instalação, o resultado de `df -h` mostrou corretamente:

- `/rom` em squashfs;
- `/overlay` em UBI;
- root em overlayfs.

### Exemplo do estado final

```text
Filesystem                Size      Used Available Use% Mounted on
/dev/root                 5.0M      5.0M         0 100% /rom
tmpfs                   492.7M    236.0K    492.5M   0% /tmp
/dev/ubi0_2             73.6M     40.0K     69.7M   0% /overlay
overlayfs:/overlay      73.6M     40.0K     69.7M   0% /
tmpfs                   512.0K         0    512.0K   0% /dev
```

Isso confirmou que:

- o roteador não estava mais em initramfs;
- o OpenWrt estava realmente instalado na flash.

---

## Configuração da WAN

A interface WAN física identificada foi:

- `eth1`

A interface recebeu IP via DHCP do roteador/modem da operadora.

### Exemplo de resultado

```text
inet 192.168.100.12/24
default via 192.168.100.1 dev eth1
```

Depois disso:

- internet no roteador funcionou;
- DNS funcionou;
- foi possível instalar LuCI.

---

## Instalação do LuCI

```bash
apk update
apk add luci
/etc/init.d/uhttpd restart
```

Depois disso, a interface web abriu normalmente em:

- <http://192.168.1.1>

---

## Configuração do Wi-Fi

No LuCI, foram ativados:

- rádio 2.4 GHz;
- rádio 5 GHz.

Com:

- rede associada à `lan`;
- segurança WPA2/WPA3;
- país configurado para `BR`.

---

## Situação final do roteador

Ao final do processo, o roteador ficou:

- com OpenWrt instalado definitivamente;
- com WAN funcionando;
- com LAN funcionando;
- com DHCP funcionando;
- com LuCI funcionando;
- com Wi-Fi ativo;
- com configuração persistente após reinicialização.

---

## O que este projeto representa

Este projeto representa:

- a **Etapa 0** do meu homelab;
- a transição de firmware proprietário para firmware aberto;
- a base para futuras fases ligadas a:
  - firewall
  - segmentação
  - hardening
  - monitoramento
  - segurança ofensiva e defensiva em laboratório

---

## Próximas fases planejadas

Depois desta etapa, os próximos passos naturais são:

- hardening básico do roteador;
- documentação mais detalhada de rede;
- firewall refinado;
- VLANs;
- monitoramento;
- integração com ferramentas de segurança.

---

## Conclusão

Instalar OpenWrt no Acer Predator Connect W6x é totalmente viável, mas o processo pode assustar no começo porque mistura vários conceitos que geralmente não são explicados de forma didática para iniciantes.

Os principais pontos que geraram confusão foram:

- ausência de pinos TTL prontos;
- dúvidas sobre serial correta;
- bootloader muito rápido;
- diferenças entre initramfs e sysupgrade;
- falhas no SCP por causa do SFTP;
- LuCI ausente no snapshot;
- erros manuais na configuração da WAN/firewall;
- expectativa errada sobre “potência máxima” no Wi-Fi.

Se este material te ajudou, considere:

- abrir uma issue;
- sugerir melhorias;
- ou dar uma estrela no repositório.

