export type Accent = 'amber' | 'red' | 'blue' | 'green';

export interface Plugin {
  /** Display name */
  name: string;
  /** One-line tagline shown under the name */
  tagline: string;
  /** Short marketing blurb */
  blurb: string;
  /** Plugin category label (chip) */
  category: string;
  /** Signature accent hue (matches the plugin's own GUI accent) */
  accent: Accent;
  /** Formats shipped */
  formats: string[];
  /** Price in USD, or null for "free / open source only" */
  price: number | null;
  /** Lemon Squeezy checkout URL — filled in once the store is live */
  buyUrl: string | null;
  /** Public GitHub repo */
  repoUrl: string;
  /** Marks the hero/flagship product */
  flagship?: boolean;
}

export const plugins: Plugin[] = [
  {
    name: 'Tube Station',
    tagline: 'Flagship tube saturator',
    blurb:
      'Chebyshev-waveshaped valve warmth with a memory/hysteresis model, calibrated makeup gain and tone tilt. Ships in mono and stereo variants.',
    category: 'Saturation',
    accent: 'amber',
    formats: ['VST3', 'CLAP', 'AU', 'LV2', 'Standalone'],
    price: 39,
    buyUrl: null,
    repoUrl: 'https://github.com/camden-plugins/tube-station',
    flagship: true,
  },
  {
    name: 'Tube Station Multiband',
    tagline: 'N-band saturator',
    blurb:
      'The Tube Station voice across a generic-N crossover — drive each band independently for surgical, program-dependent harmonic colour.',
    category: 'Saturation',
    accent: 'amber',
    formats: ['VST3', 'CLAP', 'LV2', 'Standalone'],
    price: 49,
    buyUrl: null,
    repoUrl: 'https://github.com/camden-plugins/tube-station-multiband',
  },
  {
    name: 'Off Peak',
    tagline: 'Oversampled clipper / maximizer',
    blurb:
      'A transparent, heavily-oversampled hard/soft clipper for taming peaks and squeezing out loudness without the pumping.',
    category: 'Clipper',
    accent: 'red',
    formats: ['VST3', 'CLAP', 'LV2', 'Standalone'],
    price: 29,
    buyUrl: null,
    repoUrl: 'https://github.com/camden-plugins/off-peak',
  },
  {
    name: 'Clampdown',
    tagline: 'Character compressor',
    blurb:
      'A full dynamics voice — detector, gain computer, sidechain HP, character stage, makeup and mix — with a live transfer-curve + gain-reduction display.',
    category: 'Dynamics',
    accent: 'green',
    formats: ['VST3', 'CLAP', 'LV2', 'Standalone'],
    price: 39,
    buyUrl: null,
    repoUrl: 'https://github.com/camden-plugins/clampdown',
  },
];
