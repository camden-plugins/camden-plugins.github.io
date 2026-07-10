# camden-plugins.io

Marketing site + storefront for the **Camden Plugins** audio plugin suite —
[camden-plugins.com](https://camden-plugins.com).

Built with **[Astro](https://astro.build)** + **Tailwind CSS v4**. Static, fast,
SEO-friendly. Sells signed plugin binaries via **Lemon Squeezy** (merchant of
record — handles global VAT/sales tax, license keys and secure downloads) while
pointing to the open-source GitHub repos.

## Develop

```bash
npm install
npm run dev      # http://localhost:4321
npm run build    # static output → dist/
npm run preview  # preview the production build
```

## Structure

```
public/            fonts (Camden), textures + favicon (copied from camden-core)
src/
  data/plugins.ts  ← single source of truth for the product line-up + prices
  components/       Nav, PluginCard, Logo (suite mark), Roundel (Tube Station only), Footer
  layouts/          Layout.astro (head / meta / OG)
  pages/index.astro the landing page
  styles/global.css theme tokens (palette + fonts lifted from CamdenLookAndFeel.h)
```

## Branding

- Palette + Camden font come straight from the plugin GUIs (`CamdenLookAndFeel`),
  so the site matches the products: dark blue `#181d2e`, amber `#ffaa00`
  (saturation), red `#e94560` (clippers), green `#3ed99b` (dynamics), blue
  `#3e92f4` (analysis).
- The **suite** mark (`Logo.astro`) is a neutral four-accent chip. The
  **Underground roundel** (`Roundel.astro`) is reserved for the Tube Station
  products only — other plugins get their own marks.

## Wiring up the store (Lemon Squeezy)

Each product in `src/data/plugins.ts` has a `buyUrl` field (currently `null` →
renders a "Coming soon" button). When the store is live:

1. Create the products in Lemon Squeezy and enable license-key generation.
2. Drop each product's checkout/overlay URL into `buyUrl`.
3. (Optional) add the Lemon Squeezy overlay script for in-page checkout.

## Deploy

Static output — deploy `dist/` to Cloudflare Pages or Vercel (git-push deploys),
point `camden-plugins.com` at it.
