# Publish ChurnIQ Tableau Dashboard

Tableau Public does **not** run on Linux. Publish once from **Windows or Mac**, then the Flask app embeds it in the browser on any OS.

Important: the app is currently configured to use the published dashboard already embedded in `templates/visualization.html`. Do not replace that live URL with a guessed `ChurnIQ` workbook name unless you have actually published that workbook to Tableau Public.

---

## Important: `.twb` vs CSV

| Wrong | Right |
|-------|-------|
| Upload `.twb` on the **Tableau Public website** | Use the **Tableau Public desktop app** (free download) |
| Tableau Public “needs CSV” on the website | The **CSV is the data**; the **`.twb` is the dashboard layout** |

**You need BOTH:**
- `data/train.csv` — the data
- `ChurnIQ Churn Visualisation.twb` — the charts/dashboard (optional if you build from CSV)

The desktop app opens `.twb` files. When it says it cannot find data, you **reconnect** it to `train.csv` — that is normal on a new computer.

---

## What to send your friend (zip these)

```
ChurnIQ/
├── data/train.csv
├── ChurnIQ Churn Visualisation.twb
└── scripts/publish_tableau.md   (this file)
```

---

## Method A — Open the `.twb` (try this first)

### 1. Install Tableau Public **desktop app**

Download (Windows or Mac only): https://public.tableau.com/en-us/s/download

This is a program you install — **not** the tableau.com website upload.

### 2. Open the workbook in the app

**File → Open →** select `ChurnIQ Churn Visualisation.twb`

### 3. Reconnect the CSV (expected step)

Tableau will show **“Unable to connect”** or ask for a data source because the file was created on another machine.

Do this:

1. Click **Edit Data Source** (or the warning link)
2. **Connection → Text file** (or change the existing connection)
3. Browse to **`data/train.csv`** in the folder you unzipped
4. Click **Update** / **Apply**
5. Confirm sheets show data (not empty)

### 4. Publish

1. **Server → Tableau Public → Save to Tableau Public**
2. Sign in (free account)
3. Workbook name: **`ChurnIQChurnVisualisation`** or another ChurnIQ-branded name if you intentionally publish under that name
4. Sheet name should stay **`Dashboard 1`**
5. Click **Publish**

### 5. Verify

If you publish a legitimate ChurnIQ workbook, update the `name` value in `templates/visualization.html` using the new public workbook URL.

---

## Method B — Start from CSV only (if `.twb` will not open)

If the `.twb` is broken or Tableau refuses to open it, build from the CSV:

### 1. Open Tableau Public desktop

### 2. Connect to data

**Connect → Text file →** select `data/train.csv`

### 3. Build a simple dashboard (minimum for portfolio)

Create one dashboard with these charts (same as the original project):

| Chart | Fields |
|-------|--------|
| Balance histogram | `Balance` on columns, Count on rows |
| Age area chart | `Age` on columns, Count, color by `Exited` |
| Gender churn bars | `Gender`, calculated churn rate: `SUM([Exited]) / COUNT([Exited])` |
| Active member bars | `IsActiveMember`, same churn rate formula |
| Credit card bars | `HasCrCard`, same churn rate formula |

Add filter buttons for **Geography**, **Exited**, **HasCrCard** if you have time.

### 4. Publish

Same as Method A step 4 — choose a ChurnIQ-branded workbook name only if you have actually published it.

---

## Method C — Keep the current live embed until a ChurnIQ workbook exists

The existing `templates/visualization.html` embed currently points to a live public workbook and should stay as-is until the ChurnIQ workbook is actually published:

```html
<param name='name' value='AnshivyaChurnVisualisation_17846330849110/Dashboard1' />
```

Once a real ChurnIQ workbook exists on Tableau Public, replace it with the correct published slug.

---

## After publish — on your laptop

No Tableau needed. Just run Flask:

```bash
cd ~/project/churniq/ChurnIQ
source .venv/bin/activate
python app.py
```

Open: http://localhost:9092/visualization

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| “Tableau Public doesn't support .twb” on **website** | Use the **desktop app**, not web upload |
| “Cannot find data source” | Reconnect to `data/train.csv` (Method A step 3) |
| `.twb` won't open at all | Use Method B — connect CSV and rebuild |
| Embed URL different after publish | Copy **Share → Embed Code** from Tableau, update `templates/visualization.html` |
| Published workbook has a different name | Update the `name` parameter to the actual public workbook slug |

---

## Quick message to send a collaborator

> Install Tableau Public desktop from public.tableau.com (Windows/Mac).
> Unzip the folder I sent. Open `ChurnIQ Churn Visualisation.twb` in Tableau.
> When it asks for data, point to `data/train.csv`.
> Publish the dashboard to Tableau Public under a verified ChurnIQ workbook name.
> Send me the link; then I can update `templates/visualization.html` to point to it.
