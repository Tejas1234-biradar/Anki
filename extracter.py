from lxml import etree
import json

# Load XML
tree = etree.parse("kanjidic2.xml")
root = tree.getroot()

kanji_list = []

for char in root.findall("character"):
    literal = char.findtext("literal")
    misc = char.find("misc")

    if misc is None:
        continue

    grade_text = misc.findtext("grade")
    if grade_text is None:
        continue

    grade = int(grade_text)

    # Only N5–N3 range
    if grade > 6:
        continue

    # Grade → JLPT approximation
    if grade <= 2:
        jlpt = "N5"
    elif grade <= 4:
        jlpt = "N4"
    else:
        jlpt = "N3"

    reading_meaning = char.find("reading_meaning")
    if reading_meaning is None:
        continue

    rmgroup = reading_meaning.find("rmgroup")
    if rmgroup is None:
        continue

    onyomi = []
    kunyomi = []
    meanings = []

    # Readings
    for r in rmgroup.findall("reading"):
        r_type = r.get("r_type")
        if r_type == "ja_on":
            onyomi.append(r.text)
        elif r_type == "ja_kun":
            kunyomi.append(r.text.replace(".", ""))

    # Meanings (English only)
    for m in rmgroup.findall("meaning"):
        if m.get("m_lang") is None:
            meanings.append(m.text)

    if not onyomi and not kunyomi:
        continue

    kanji_list.append({
        "kanji": literal,
        "onyomi": onyomi,
        "kunyomi": kunyomi,
        "meanings": meanings,
        "jlpt": jlpt
    })

print(f"Extracted {len(kanji_list)} kanji")

# Write JSON
with open("kanji_n3.json", "w", encoding="utf-8") as f:
    json.dump(kanji_list, f, ensure_ascii=False, indent=2)
