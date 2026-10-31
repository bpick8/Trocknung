# Absolute Feuchte / Dampfdichte
Der Partialdruck eines Gases $e$ innerhalb eines Gasgemisches kann durch Umstellung der [allgemeinen Gasgleichung](https://de.wikipedia.org/wiki/Thermische_Zustandsgleichung_idealer_Gase)

$$
    p \cdot V = n \cdot R_{m} \cdot T  \rightarrow   p = \frac{n}{V} \cdot R_m \cdot T
$$
mit folgender Formel näherungsweise berechnet werden:
$$
    e = \rho \cdot R \cdot T 
$$
mit 
* $p$ : Druck $\text{Pa} = \frac{\text{N}}{\text{m}^2} = \frac{J}{\text{m} \cdot \text{m}^2} = \frac{J}{\text{m}^3}$ <p/>
* $V$ : Volumen in $\text{m}^3$ <p/>
* $n$ : Stoffmenge in Mol <p/>
* $R_{m}$ : Gaskonstande 8,31446261815324 $\frac{\mathrm{J}}{\mathrm{mol} \ \mathrm{K}}$ <p/>
* $T$ : Termodynamische Temperatur in Kelvin <p/>
* $\vartheta$ : Termodynamische Temperatur in °C mit $T = 273{,}15 +  \vartheta$<p/>
* $\rho$ : Dichte in $$

Für die Dampdichte $\rho_v$ folgt:
$$
    \rho_v = \frac{p}{R_v \cdot T}
$$

Mit Gaskonstante für Wasserdampf (*vapor*): $R_v = 461,52\,\frac{\text{J}}{\text{kg}\,\text{K}}$ und Sättigungsdampfdruck $\rho_s(T)$ folgt für den Druck  $p$

$$
    p = \varphi\cdot\rho_s(T)
$$

Damit kann die __absolute Feuchte__ der Luft in $\text{g} / \text{m}^3$ mit der folgenden Formel berechnet werden:

$$
\rho_v(\varphi, T) = \frac{\varphi \cdot p_s(T)}{R_v \cdot T_K}
$$
mit 
* $\varphi$ : relative Luftfeuchtigkeit (0 bis 1)
* $p_s(T)$ :  Sättigungsdampfdruck in Pa (*saturation*)
* $R_v = 461,52$ : J/(kg·K), die Gaskonstante für Wasserdampf (*vapor*)
* $T_K = T_{°\text{C}} + 273,15\, \text{K}$ : Temperatur in Kelvin

Der Sättigungsdampfdruck $p_s(T)$ kann mit der [__Tetens-Gleichung__ bzw. __Magnus Gleichung__](https://www.chemie.de/lexikon/S%C3%A4ttigungsdampfdruck.html) approximiert werden:
$$
    p_s(\vartheta) = 611{,}2\, \text{Pa} \cdot e^{\dfrac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12°\text{C}}}
$$
wobei $\vartheta$ die Temperatur in °C angegeben ist.
Es gilt: 
* $ -30\,{}^\circ\mathrm{C} \leq 70\,{}^\circ\mathrm{C}$
* $ p_s(\vartheta = 0\,{}^\circ\mathrm{C}) = 6{,}11213\;\mathrm{hPa} = 611{,}213\;\mathrm{Pa}$
Die Konstanten variieren in der Literatur, z.B.:
$$
    p_s(\vartheta) = 611{,}153\, \text{Pa} \cdot e^{\dfrac{22{,}4433 \cdot \vartheta}{\vartheta + 272{,}186°\text{C}}}
$$

# Aktueller Code in App und Apama-Regel
Berechnung der absoluten Feuchte aus gemessenen Werten 
* relative Feuchtigkeit: rF in Prozent (0 .. 100)
* Temperatur: T in °C
* absolute Feuchte aF in $\frac{\mathrm{g}}{\mathrm{kg}}$
````java
const calcValue = ((((rF / 100) * (6.112 * Math.pow(2.7182881, (17.62 * T) / (243.12 + T)) * 100)) / 461.5 / (T + 273)) * 1000) / 1.2
````
$$
\begin{align*}
    \text{aF}  

    &= \frac{\frac{\frac{\text{rF}}{100} \cdot 6{,}112 \cdot 2{,}7182881^{\frac{17{,}62 \cdot \vartheta}{243{,}12 + \vartheta}} \cdot 100}
                  {461{,}5 \cdot (\vartheta + 273)} \cdot 1000}
            {1{,}2} 
        \\

    &= \frac{\text{rF} \cdot 6{,}112 \cdot e^{\frac{17{,}62 \cdot \vartheta}{243{,}12 + \vartheta}} }
            {461{,}5 \cdot (\vartheta + 273)}
        \cdot \frac{1000}{1,2}
        \\
\end{align*}
$$
Mit der __Tetens-Gleichung__ bzw. __Magnus Gleichung__:
$$
\begin{align*}
    \text{aF}  
    &= \frac{\text{rF} \cdot 611{,}2\, \frac{\text{J}}{\text{m}^3} \cdot e^{\dfrac{17{,}62 \cdot \vartheta}{\vartheta + 243{,}12}}}
    {461{,}52 \frac{\text{J}}{\text{kg} \cdot \text{K}} \cdot (\vartheta + 273{,}15)\, \text{K}}
    \cdot \frac{10}{1{,}204\, \frac{\text{kg}}{\text{m}^3}}
\end{align*}

$$
* Dichte trockener Luft bei bei Standardbedingungen (20 °C auf Meereshöhe, 101,3 Pa): $1,204 \frac{\text{kg}}{\text{m}^3}$
* Faktor 10: 
    * Umrechnung Prozent von (0 .. 100) in (0 .. 1)
    * Umrechung der Masse von kg in g 


* Der Grund für das Auftauchen: Deine Formel berechnet die absolute Feuchte nicht wie üblich in Gramm pro Kubikmeter ($\mathrm{g/m}^{\mathrm{3}}$), sondern im Mischungsverhältnis Gramm pro Kilogramm trockene Luft ($\mathrm{g/kg}$).
* Um von der Masse pro Volumen ($\mathrm{m}^{\mathrm{3}}$) auf die Masse pro Luftmasse ($\mathrm{kg}$) zu kommen, muss durch die Dichte der Luft geteilt werden.

Alle Einheiten können gekürzt werden. Es ergibt sich ein Verhältnis der Masse von Wasserdampf zur Masse von trockener Luft. Damit kann die Einheit  $\frac{\text{g}}{\text{kg}}$ gewählt werden.

# Betrachtung für die die Dämmschichtrocknung
## Druck im Saugrohr
Im Saugrohr eines Staubsaugers herrscht ein Unterdruck von typischerweise 100 bis 250 Hektopascal (hPa) im Vergleich zum normalen Luftdruck der Umgebung.

Da der normale atmosphärische Luftdruck bei etwa 101,3 Pa liegt, beträgt der absolute Druck im Saugrohr während des Betriebs ungefähr 76 Pa bis 91 Pa.

## Was bedeutet das für die Berechnung der relativen Feuchte?
Nein, diese Formel gilt in dieser exakten Form nicht universell, sondern ist an den Luftdruck auf Meereshöhe gebunden. Das liegt vor allem an der Zahl 1,2 (der Dichte der Luft), die sich bei Druckänderungen drastisch verändert.

Wenn du den Druck extrem absenkst – wie in deinem Beispiel auf 65 Pascal (was einem extremen Vakuum oder der Atmosphäre des Planeten Mars entspricht) – bricht die Formel in dieser Formelstruktur gleich doppelt zusammen.

__Das passiert im Detail:__

1. Die Luftdichte (die "1,2") geht gegen Null

Die Dichte der Luft ist direkt proportional zum Luftdruck. Wenn der Druck von ca. 101.325 Pa (Meereshöhe) auf 65 Pa sinkt, ist kaum noch Luft vorhanden.
* Die Dichte trockener Luft beträgt bei 65 Pa und 20 °C nicht mehr $1{,}2\,\mathrm{kg/m^3}$\)$, sondern nur noch winzige $0{,}00077\,\mathrm{kg/m^3}$.
* Da du in der Formel durch diesen Wert teilst, würde der berechnete Wert für $\text{aF}$ (Gramm Wasserdampf pro Kilogramm Luft) extrem ansteigen. Es gibt schlicht kaum noch Luftmoleküle, auf die sich der Wasserdampf verteilen kann.

## 2. Das physikalische Limit: Der Dampfdruck übersteigt den Gesamtdruck

Das viel größere Problem bei 65 Pascal ist ein thermodynamisches:
* Der Zähler der Magnus-Formel berechnet den Sättigungsdampfdruck des Wassers. Bei einer normalen Raumtemperatur von 20 °C beträgt dieser ca. 2.340 Pascal.
* Wenn der Gesamtdruck der Umgebung aber nur 65 Pascal beträgt, liegt dieser weit unter dem Dampfdruck von flüssigem Wasser oder Eis.
__Die Folge:__ Wasser kann bei diesem Druck bei normalen Temperaturen überhaupt nicht mehr als Flüssigkeit existieren. Es würde sofort __sieden (kochen) und komplett zu Gas werden__, bis der Dampfdruck den Umgebungsdruck angleicht – oder, falls es sich um einen offenen Raum handelt, komplett in den Weltraum/das Vakuum expandieren (Sublimation/Verdampfung). Eine "relative Luftfeuchtigkeit" unter 100% macht bei 65 Pa Gesamtdruck und normalen Temperaturen physikalisch keinen Sinn mehr, da der Wasserdampf allein schon den Raum ausfüllen und einen höheren Druck erzeugen würde.

## Wie berechnet man die absolute Feuchte richtig bei variablem Druck?

In der Meteorologie und Thermodynamik nutzt man für das Mischungsverhältnis (\(x\) oder \(q\) in \(\mathrm{g/kg}\)) bei variablem Druck \(p\) nicht die feste Luftdichte, sondern die universelle Formel:
$$
    \text{aF}=622\cdot \frac{e}{p-e}\quad \left[\frac{\mathrm{g}}{\mathrm{kg}}\right]
$$
* $e$ ist der tatsächliche Wasserdampfpartialdruck (berechnet aus $\text{rF} \cdot \text{Sättigungsdampfdruck}$).
* $p$ ist der tatsächliche Gesamtdruck der Luft (z. B. 101.325 Pa auf Meereshöhe).
* 622 ist der Faktor für das Verhältnis der Molmassen von Wasser und Luft ($0{,}622 \cdot 1000\,\mathrm{g/kg}$).
Hier siehst du: Sinkt der Gesamtdruck $p$ und nähert sich dem Dampfdruck $e$ an, geht der Nenner gegen Null und das Verhältnis g/kg geht gegen Unendlich – weil keine trockene Luft mehr übrig ist, sondern der Raum nur noch aus purem Wasserdampf besteht.

Ein typischer Dämmschichttrockner (Seitenkanalverdichter oder Turbinen-Vakuumaggregat) erzeugt einen Unterdruck von etwa 50 bis 250 mbar (also 5.000 bis 25.000 Pascal) unter dem normalen Luftdruck.


## 2. Was passiert mit der Formel beim Saugen?

Der Gesamtdruck in der Dämmschicht sinkt durch den Sauger leicht ab (z. B. von 1013 mbar auf ca. 950 mbar absolut).
* __Der Effekt auf die Feuchte:__ Weil der Druck leicht sinkt, dehnt sich die Luft aus. Ihre Dichte sinkt ein wenig (sie wird geringer als die 1,2 kg/m³).
* __Das Ergebnis in der Praxis:__ Die Luft kann durch den veränderten Druck pro Kubikmeter sogar geringfügig mehr Wasserdampf aufnehmen, und die Verdunstung des Wassers in der Dämmschicht wird beschleunigt.
* __Für die Messung:__ Wenn du die Feuchtigkeit der abgesaugten Luft misst, um den Trocknungsfortschritt zu überwachen, nutzen die meisten Handmessgeräte Sensoren, die die __relative Feuchte und Temperatur__ messen. Da der Druckunterschied zur Raumluft meist unter 10 % liegt, ignorieren Standard-Messgeräte diesen Druckabfall. Die unkorrigierte Magnus-Formel liefert dann immer noch einen praxistauglichen Näherungswert.


## 3. Warum die absolute Feuchte $(\mathrm{g/kg}$ oder $\mathrm{g/m}^{\mathrm{3}}$) hier entscheidend ist

Bei der Dämmschichttrocknung nutzt man die absolute Feuchte für den __Prozessvergleich__:
• Du misst die absolute Feuchte der __Raumluft__ (die in die Dämmschicht nachströmt).
• Du misst die absolute Feuchte der __Prozessluft__ (die aus dem Sauger kommt).
• __Die Trocknungsregel:__ Erst wenn die absolute Feuchte der austretenden Luft nahezu identisch mit der nachströmenden Raumluft ist, befindet sich kein freies Wasser mehr in der Dämmschicht und die Trocknung ist abgeschlossen.

# Erweiterung der Gleichung um dem Druck $p$
Um den variablen Gesamtdruck $p$ (in Pascal) korrekt in der Formel abzubilden, müssen wir die feste Luftdichte ($1{,}204\,\mathrm{kg/m^3}$) durch die Zustandsgleichung für feuchte Luft bzw. das molare Massenverhältnis ersetzen.

Für das Mischungsverhältnis in $\mathrm{g/kg}$ lautet die exakte physikalische Gleichung unter Einbeziehung des Gesamtdrucks $p$:
$$
    \text{aF}(\vartheta ,\text{rF},p)=1000\cdot \frac{M_{w}}{M_{l}}\cdot \frac{e(\vartheta ,\text{rF})}{p-e(\vartheta ,\text{rF})}
$$
Da das Verhältnis der molaren Massen von Wasserdampf und trockener Luft $\frac{M_w}{M_l} \approx \frac{18{,}015}{28{,}96} \approx 0{,}622$ beträgt, vereinfacht sich dies mit deiner ursprünglichen Struktur (inklusive des Prozentfaktors für die $\text{rF}$) zu:
$$
    \text{aF}=\frac{10}{100}\cdot 622\cdot \frac{\text{rF}\cdot 611,2\cdot e^{\dfrac{17,62\cdot \vartheta }{\vartheta +243,12}}}{p-\left(\frac{\text{rF}}{100}\cdot 611,2\cdot e^{\dfrac{17,62\cdot \vartheta }{\vartheta +243,12}}\right)}
$$
Kompakt geschrieben mit dem tatsächlichen Wasserdampfpartialdruck \(e\) in Pascal:
$$
    e=\frac{\text{rF}}{100}\cdot 611,2\cdot e^{\dfrac{17,62\cdot \vartheta }{\vartheta +243,12}}
$$
$$
    \text{aF}=622\cdot \frac{e}{p-e}\quad \left[\frac{\mathrm{g}}{\mathrm{kg}}\right]
$$

# 2. Python-Programm zur Berechnung und 3D-Visualisierung

Für die Dämmschichttrocknung wählen wir folgende sinnvolle Praxisbereiche:
* Temperatur ($\vartheta$): $15\ ^\circ\mathrm{C}$ bis $45\ ^\circ\mathrm{C}$ (typische Erwärmung durch den Seitenkanalverdichter).
* Unterdruck ($p$): $80.000\,\mathrm{Pa}$ bis $101.325\,\mathrm{Pa}$. Da der Sauger einen Unterdruck erzeugt, sinkt der absolute Druck in der Dämmschicht. Ein Unterdruck von bis zu $200\,\mathrm{mbar}$ entspricht ca. $80.000\,\mathrm{Pa}$ absolutem Druck.
* Relative Feuchte ($\text{rF}$): Wir fixieren diese beispielhaft auf einen hohen Wert ($80\%$), der typisch für die feuchte Prozessluft zu Beginn/Mitte der Trocknung ist, um den Einfluss von Temperatur und Druck sauber in 3D darzustellen.

## Hier ist der Python-Code, den du kopieren und ausführen kannst:
````python
import numpy as np
import matplotlib.pyplot as plt
from shortcuts import chartPlaceholder  # Falls in spezifischer Umgebung genutzt

def absolute_feuchte(temp_c, rf_prozent, druck_pa):
    """
    Berechnet die absolute Feuchte (Mischungsverhältnis) in g/kg
    unter Berücksichtigung des Gesamtdrucks p.
    """
    # Sättigungsdampfdruck nach Magnus-Gleichung in Pa
    e_sat = 611.2 * np.exp((17.62 * temp_c) / (temp_c + 243.12))
    
    # Tatsächlicher Wasserdampfpartialdruck in Pa
    e = (rf_prozent / 100.0) * e_sat
    
    # Absolute Feuchte in g/kg (Verhältnis Wasserdampfmasse zu trockener Luftmasse)
    # Vermeidung von Division durch Null, falls p <= e (physikalisch unmöglich)
    af = 622.0 * e / (druck_pa - e)
    return af

# Sinnvolle Bereiche für die Dämmschichttrocknung definieren
temp_range = np.linspace(15, 45, 100)      # 15°C bis 45°C
# Normaldruck (101325 Pa) bis ca. 210 mbar Unterdruck (80000 Pa absolut)
druck_range = np.linspace(80000, 101325, 100) 

# Grid für den 3D-Plot erstellen
T, P = np.meshgrid(temp_range, druck_range)

# Wir fixieren die relative Feuchte für diesen Plot auf 80% (feuchte Dämmschicht)
RF_FIX = 80.0
AF = absolute_feuchte(T, RF_FIX, P)

# 3D-Plot erstellen
fig = plt.subplots(figsize=(10, 7), subplot_kw={"projection": "3d"})
ax = fig[1]

# Oberfläche plotten
surf = ax.plot_surface(T, P / 100.0, AF, cmap='viridis', edgecolor='none', alpha=0.9)

# Beschriftungen und Titel
ax.set_title(f'Absolute Feuchte aF in g/kg bei rF = {RF_FIX}%\n(Einfluss von Temperatur und Unterdruck)', fontsize=12, pad=20)
ax.set_xlabel('Temperatur (°C)', fontsize=10, labelpad=10)
ax.set_ylabel('Absoluter Druck (hPa)', fontsize=10, labelpad=10)
ax.set_zlabel('Absolute Feuchte aF (g/kg)', fontsize=10, labelpad=10)

# Ansichtswinkel für optimale Sichtbarkeit anpassen
ax.view_init(elev=25, azim=-130)

# Farbskala hinzufügen
cbar = fig[0].colorbar(surf, ax=ax, shrink=0.5, aspect=10, pad=0.1)
cbar.set_label('aF [g/kg]')

plt.tight_layout()
plt.show()
````

### Was zeigt dir diese 3D-Grafik für die Praxis?

1. __Der Temperatureffekt (Dominant):__ Wenn die Temperatur von $15\ ^\circ\mathrm{C}$ auf $45\ ^\circ\mathrm{C}$ steigt, explodiert die absolute Feuchte (die Kurve steigt steil nach rechts an). Das zeigt, warum erwärmte Luft extrem viel mehr Wasser aus der Dämmschicht abtransportieren kann.
2. __Der Druckeffekt (Dezent, aber vorhanden):__ Wenn der absolute Druck sinkt (im Plot nach links in Richtung $800\,\mathrm{hPa}$ bzw. tiefer in das Vakuum des Saugers), wandert die Kurve leicht nach oben. Die Luft kann bei Unterdruck also pro Kilogramm Trockenluft etwas mehr Gramm Feuchtigkeit aufnehmen als bei normalem Umgebungsdruck.

Möchtest du das Skript so angepasst haben, dass der Druck konstant bleibt und stattdessen die relative Feuchte (0–100%) auf der zweiten Achse dargestellt wird, um den klassischen Abtrocknungseffekt zu sehen?

## Klassischer Abtrockungseffekt

Hier ist die angepasste Visualisierung für den __klassischen Abtrocknungseffekt__. In der Praxis der Dämmschichttrocknung bleibt der Arbeitsdruck des Saugers während des Betriebs meist relativ konstant (z. B. bei einem typischen Unterdruck von ca. 100 mbar, was einem absoluten Druck von 91.325 Pa entspricht).

Was sich im Laufe der Trocknung massiv verändert, sind die __Temperatur__ (durch die Erwärmung des Verdichters) und die __relative Feuchte__ (die absinkt, je trockener die Dämmschicht wird).

### Python-Programm für den Abtrocknungseffekt (Konstanter Druck)

Dieses Skript fixiert den Druck auf ein realistisches Betriebsvakuum und stellt die absolute Feuchte in Abhängigkeit von Temperatur und relativer Feuchte dar.

````python
import numpy as np
import matplotlib.pyplot as plt

def absolute_feuchte_konstant_p(temp_c, rf_prozent, druck_pa=91325):
    """
    Berechnet die absolute Feuchte (g/kg) bei einem fixen Systemdruck (Standard: 91325 Pa).
    """
    # Sättigungsdampfdruck nach Magnus in Pa
    e_sat = 611.2 * np.exp((17.62 * temp_c) / (temp_c + 243.12))
    # Tatsächlicher Dampfdruck
    e = (rf_prozent / 100.0) * e_sat
    # Absolute Feuchte in g/kg
    af = 622.0 * e / (druck_pa - e)
    return af

# Sinnvolle Bereiche für den Abtrocknungsprozess
temp_range = np.linspace(15, 45, 100)  # 15°C bis 45°C (Erwärmung der Prozessluft)
rf_range = np.linspace(10, 90, 100)    # 10% (trocken) bis 90% (startfeucht)

# 2D-Grid für den 3D-Plot aufbauen
T, RF = np.meshgrid(temp_range, rf_range)

# Berechnung bei ca. 100 mbar Unterdruck (913.25 hPa absolut)
P_BETRIEB = 91325 
AF = absolute_feuchte_konstant_p(T, RF, P_BETRIEB)

# 3D-Plot erstellen
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Oberfläche plotten
surf = ax.plot_surface(T, RF, AF, cmap='plasma', edgecolor='none', alpha=0.9)

# Achsenbeschriftungen und Titel
ax.set_title(f'Klassischer Abtrocknungseffekt\nAbsolute Feuchte aF bei konstantem Betriebsdruck ({P_BETRIEB/100:.1f} hPa)', fontsize=12, pad=20)
ax.set_xlabel('Temperatur (°C)', fontsize=10, labelpad=10)
ax.set_ylabel('Relative Feuchte rF (%)', fontsize=10, labelpad=10)
ax.set_zlabel('Absolute Feuchte aF (g/kg)', fontsize=10, labelpad=10)

# Blickwinkel anpassen, um den steilen Anstieg perfekt zu sehen
ax.view_init(elev=28, azim=-140)

# Farbskala
cbar = fig.colorbar(surf, ax=ax, shrink=0.5, aspect=10, pad=0.1)
cbar.set_label('aF [g/kg]')

plt.tight_layout()
plt.show()
````

### Die zwei Kern-Erkenntnisse dieser Grafik für dein Projekt:

* __Der "Turbo-Effekt" bei Erwärmung:__ Schau dir den Punkt bei 45 °C und 90 % rF an (hintere obere Ecke). Dort erreicht die absolute Feuchte ihren absoluten Höchstwert. Das bedeutet: Warme Luft, die durch eine noch klatschnasse Dämmschicht gesaugt wird, nimmt gigantische Mengen Wasser pro Kilogramm Luft auf. Deswegen sind Trocknungen in den ersten Tagen am effektivsten, wenn die Aggregate warmgelaufen sind.
* __Die Ziel-Kurve (Das Trocknungsende):__ Während der Estrich trocknet, wandert dein Betriebspunkt auf der Grafik von den hohen rF-Werten (z. B. 80 %) langsam nach unten in Richtung 20 % oder 30 % rF. Die absolute Feuchte der austretenden Luft sinkt immer weiter ab, bis sie sich dem Wert der nachströmenden Raumluft angleicht.




















