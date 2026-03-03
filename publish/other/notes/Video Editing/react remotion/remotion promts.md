
## cool hero graphic animation transparent

### prompt 1 - hero image
```
import React, {useMemo} from "react";
import {
	AbsoluteFill,
	Easing,
	interpolate,
	random,
	spring,
	useCurrentFrame,
} from "remotion";

type Props = {
	src: string;
	title?: string;
	durationInFrames?: number; // default 180
	fps?: number; // default 30
	intensity?: number; // default 1
};

const clamp = (v: number, lo: number, hi: number) => Math.max(lo, Math.min(hi, v));
const lerp = (a: number, b: number, t: number) => a + (b - a) * t;

const smooth01 = (t: number) => t * t * (3 - 2 * t); // smoothstep
const sin01 = (t: number) => 0.5 + 0.5 * Math.sin(t); // [-1,1] -> [0,1]

const easeInOut = Easing.inOut(Easing.cubic);

/**
 * Deterministic pseudo-random in [0,1) based on a numeric seed.
 * Uses Remotion's random() under the hood (deterministic per render).
 */
const seeded = (seed: number) => random(String(seed));

/**
 * A smooth oscillation - no harshness. Returns [-1,1].
 */
const osc = (frame: number, fps: number, hz: number, phase = 0) => {
	const t = (frame / fps) * hz * Math.PI * 2 + phase;
	return Math.sin(t);
};

export const ImageHeroTransparentFX: React.FC<Props> = ({
	src,
	title,
	durationInFrames = 180,
	fps = 30,
	intensity = 1,
}) => {
	const frame = useCurrentFrame();

	const I = clamp(intensity, 0, 3);

	// ---- Timing ----
	const enterEnd = 30;
	const exitLen = 25;
	const exitStart = Math.max(0, durationInFrames - exitLen);

	const enterProg = clamp(frame / enterEnd, 0, 1);
	const exitProg = clamp((frame - exitStart) / exitLen, 0, 1);
	const exitEase = smooth01(exitProg);

	// ---- Card entrance spring ----
	const enterSpring = spring({
		frame: frame,
		fps,
		from: 0,
		to: 1,
		config: {
			damping: 14,
			stiffness: 120,
			mass: 0.9,
		},
		durationInFrames: enterEnd,
	});

	// Base transforms (entrance)
	const enterScale = lerp(0.92, 1.0, enterSpring);
	const enterOpacity = interpolate(frame, [0, enterEnd], [0, 1], {
		extrapolateLeft: "clamp",
		extrapolateRight: "clamp",
		easing: Easing.out(Easing.cubic),
	});
	const enterY = lerp(40, 0, enterSpring);
	const enterRot = lerp(-2, 0, enterSpring);

	// Hero rhythm (gentle)
	const heroT = frame / fps;
	const heroRot = 1.2 * I * osc(frame, fps, 0.07, 0.4); // ±1.2deg @ ~0.07Hz
	const heroParX = 10 * I * osc(frame, fps, 0.09, 1.2);
	const heroParY = 6 * I * osc(frame, fps, 0.11, 2.1);
	const heroPulse = 1 + 0.015 * I * sin01(heroT * Math.PI * 2 * 0.08); // tiny pulse

	// Exit transforms
	const exitOpacity = lerp(1, 0, exitEase);
	const exitScale = lerp(1, 0.98, exitEase);
	const exitY = lerp(0, 20, exitEase);
	const exitRot = lerp(0, -2, exitEase);

	// Combined card values
	const cardOpacity = enterOpacity * exitOpacity;
	const cardScale = enterScale * heroPulse * exitScale;
	const cardY = enterY + heroParY + exitY;
	const cardX = heroParX;
	const cardRot = enterRot + heroRot + exitRot;

	// ---- Layout constants ----
	const cardW = 1120;
	const cardH = 630;
	const radius = 24;

	// FX pulse synced with hero rhythm (subtle)
	const fxPulse = 1 + 0.06 * I * sin01(heroT * Math.PI * 2 * 0.08);
	const fxAlpha = (0.55 + 0.25 * sin01(heroT * Math.PI * 2 * 0.06 + 0.9)) * I;
	const fxOpacityGate = clamp(cardOpacity * 1.1, 0, 1); // fade FX with card

	// ---- Optional light sweep (clipped to card) ----
	const sweepStart = 40;
	const sweepEnd = 80;
	const sweepT = interpolate(frame, [sweepStart, sweepEnd], [0, 1], {
		extrapolateLeft: "clamp",
		extrapolateRight: "clamp",
		easing: Easing.inOut(Easing.cubic),
	});
	const sweepOpacity = interpolate(frame, [sweepStart, sweepStart + 8, sweepEnd - 8, sweepEnd], [0, 0.18, 0.18, 0], {
		extrapolateLeft: "clamp",
		extrapolateRight: "clamp",
		easing: Easing.inOut(Easing.quad),
	}) * I;

	// Sweep bar travels diagonally across the card
	const sweepX = lerp(-0.9, 0.9, sweepT); // relative
	const sweepY = lerp(0.6, -0.6, sweepT); // relative

	// ---- Particles (deterministic) ----
	const particles = useMemo(() => {
		const count = Math.round(28 + 10 * clamp(I, 0, 1)); // 28–38
		const arr = new Array(count).fill(null).map((_, idx) => {
			const s0 = seeded(1000 + idx * 7);
			const s1 = seeded(2000 + idx * 11);
			const s2 = seeded(3000 + idx * 13);
			const s3 = seeded(4000 + idx * 17);

			// position relative to card centre (stay behind card)
			const px = lerp(-cardW * 0.65, cardW * 0.65, s0);
			const py = lerp(-cardH * 0.65, cardH * 0.65, s1);

			// size and speed
			const r = lerp(1.2, 3.2, s2) * (0.9 + 0.3 * I);
			const sp = lerp(0.06, 0.14, s3); // Hz-ish
			const ph = lerp(0, Math.PI * 2, seeded(5000 + idx * 19));

			const life = lerp(0.6, 1.4, seeded(6000 + idx * 23));
			const twinkle = lerp(0.4, 1.0, seeded(7000 + idx * 29));

			// colour leaning cyan/magenta without going full disco
			const huePick = seeded(8000 + idx * 31);
			const colour =
				huePick < 0.6
					? "rgba(110, 220, 255, 1)" // cyan-ish
					: "rgba(196, 120, 255, 1)"; // violet-ish

			return {idx, px, py, r, sp, ph, life, twinkle, colour};
		});
		return arr;
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [cardW, cardH, I]);

	// ---- Rings/arcs configuration ----
	const rings = [
		{
			r: 260,
			stroke: "rgba(120, 220, 255, 0.55)",
			width: 3,
			dash: "26 18",
			rotSpeed: 0.12,
			scaleAmp: 0.035,
			phase: 0.2,
			opacity: 0.28,
		},
		{
			r: 340,
			stroke: "rgba(196, 120, 255, 0.5)",
			width: 2.5,
			dash: "18 22",
			rotSpeed: -0.09,
			scaleAmp: 0.03,
			phase: 1.1,
			opacity: 0.22,
		},
		{
			r: 420,
			stroke: "rgba(140, 255, 210, 0.42)",
			width: 2,
			dash: "10 26",
			rotSpeed: 0.07,
			scaleAmp: 0.025,
			phase: 2.0,
			opacity: 0.18,
		},
	];

	// ---- Root must remain fully transparent ----
	return (
		<AbsoluteFill
			style={{
				// No background. Transparent canvas.
				backgroundColor: "transparent",
				justifyContent: "center",
				alignItems: "center",
				width: 1920,
				height: 1080,
				overflow: "hidden",
			}}
		>
			{/* FX layer behind card (still transparent overall) */}
			<div
				style={{
					position: "absolute",
					left: "50%",
					top: "50%",
					width: cardW * 1.8,
					height: cardH * 1.8,
					transform: `translate(-50%, -50%) translate(${cardX * 0.35}px, ${cardY * 0.35}px) rotate(${cardRot * 0.4}deg) scale(${fxPulse})`,
					opacity: fxOpacityGate,
					pointerEvents: "none",
				}}
			>
				{/* Neon aura blobs (blurred divs) */}
				<div
					style={{
						position: "absolute",
						left: "50%",
						top: "50%",
						width: cardW * 1.1,
						height: cardH * 0.95,
						transform: "translate(-50%, -50%)",
						filter: `blur(${48 + 18 * I}px)`,
						mixBlendMode: "screen",
						opacity: 0.22 * fxPulse * (0.85 + 0.15 * I),
					}}
				>
					{/* Blob 1 */}
					<div
						style={{
							position: "absolute",
							left: "18%",
							top: "22%",
							width: "46%",
							height: "42%",
							borderRadius: 999,
							background:
								"radial-gradient(circle at 30% 30%, rgba(110, 220, 255, 0.95), rgba(110, 220, 255, 0))",
							opacity: 0.95,
						}}
					/>
					{/* Blob 2 */}
					<div
						style={{
							position: "absolute",
							left: "42%",
							top: "18%",
							width: "52%",
							height: "50%",
							borderRadius: 999,
							background:
								"radial-gradient(circle at 60% 35%, rgba(196, 120, 255, 0.9), rgba(196, 120, 255, 0))",
							opacity: 0.85,
						}}
					/>
					{/* Blob 3 */}
					<div
						style={{
							position: "absolute",
							left: "30%",
							top: "48%",
							width: "56%",
							height: "52%",
							borderRadius: 999,
							background:
								"radial-gradient(circle at 55% 60%, rgba(140, 255, 210, 0.75), rgba(140, 255, 210, 0))",
							opacity: 0.7,
						}}
					/>
				</div>

				{/* Rings/arcs (SVG) */}
				<svg
					width="100%"
					height="100%"
					viewBox={`0 0 ${cardW * 1.8} ${cardH * 1.8}`}
					style={{
						position: "absolute",
						left: 0,
						top: 0,
						overflow: "visible",
						filter: `blur(${0.15 + 0.25 * I}px)`,
						mixBlendMode: "screen",
						opacity: clamp(0.9 * I, 0, 1),
					}}
				>
					{rings.map((r, i) => {
						const rot = (frame / fps) * 360 * r.rotSpeed + r.phase * 30;
						const scl = 1 + r.scaleAmp * I * osc(frame, fps, 0.08 + i * 0.02, r.phase);
						const dashOffset =
							(frame * (0.55 + i * 0.25) * (0.8 + 0.35 * I)) % 200;

						const cx = (cardW * 1.8) / 2;
						const cy = (cardH * 1.8) / 2;

						return (
							<g
								key={i}
								transform={`translate(${cx} ${cy}) rotate(${rot}) scale(${scl}) translate(${-cx} ${-cy})`}
								opacity={r.opacity * (0.55 + 0.45 * fxPulse) * fxOpacityGate}
							>
								<circle
									cx={cx}
									cy={cy}
									r={r.r}
									fill="none"
									stroke={r.stroke}
									strokeWidth={r.width * (0.85 + 0.35 * I)}
									strokeDasharray={r.dash}
									strokeDashoffset={dashOffset}
									strokeLinecap="round"
								/>
							</g>
						);
					})}
				</svg>

				{/* Particle drift */}
				<div
					style={{
						position: "absolute",
						inset: 0,
						mixBlendMode: "screen",
						opacity: fxOpacityGate * clamp(0.9 * I, 0, 1),
						filter: `blur(${0.1 + 0.2 * I}px)`,
					}}
				>
					{particles.map((p) => {
						const t = frame / fps;

						// Drift with sin/cos, deterministic phase
						const dx = (10 + 18 * I) * Math.sin(t * Math.PI * 2 * p.sp + p.ph);
						const dy = (8 + 14 * I) * Math.cos(t * Math.PI * 2 * (p.sp * 0.8) + p.ph * 1.3);

						// Soft fade cycle per particle
						const fade = 0.45 + 0.55 * sin01(t * Math.PI * 2 * (0.05 + 0.03 * p.life) + p.ph);
						const tw = 0.6 + 0.4 * sin01(t * Math.PI * 2 * (0.11 + 0.07 * p.twinkle) + p.ph * 0.7);

						const a = 0.18 * fade * tw * (0.55 + 0.45 * I);

						return (
							<div
								key={p.idx}
								style={{
									position: "absolute",
									left: "50%",
									top: "50%",
									width: p.r * 2,
									height: p.r * 2,
									borderRadius: 999,
									transform: `translate(-50%, -50%) translate(${p.px + dx}px, ${p.py + dy}px)`,
									backgroundColor: p.colour,
									opacity: a,
									boxShadow: `0 0 ${6 + 10 * I}px rgba(140, 220, 255, ${0.18 + 0.12 * I})`,
								}}
							/>
						);
					})}
				</div>

				{/* Very subtle central glow spot (still behind card) */}
				<div
					style={{
						position: "absolute",
						left: "50%",
						top: "50%",
						width: cardW * 0.85,
						height: cardH * 0.7,
						transform: "translate(-50%, -50%)",
						borderRadius: 999,
						filter: `blur(${60 + 20 * I}px)`,
						background:
							"radial-gradient(circle at 50% 50%, rgba(120, 220, 255, 0.18), rgba(196, 120, 255, 0.10), rgba(0,0,0,0))",
						mixBlendMode: "screen",
						opacity: 0.22 * fxAlpha * fxOpacityGate,
					}}
				/>
			</div>

			{/* Foreground image card */}
			<div
				style={{
					width: cardW,
					height: cardH,
					borderRadius: radius,
					overflow: "hidden",
					position: "relative",
					transform: `translate(${cardX}px, ${cardY}px) rotate(${cardRot}deg) scale(${cardScale})`,
					opacity: cardOpacity,
					boxShadow: `0 22px ${48 + 24 * I}px rgba(0,0,0, ${0.28 + 0.10 * I})`,
					border: "1px solid rgba(255,255,255,0.12)",
					backgroundColor: "transparent", // keep card itself transparent; image fills it
					willChange: "transform, opacity",
				}}
			>
				<img
					src={src}
					alt={title ?? "Hero image"}
					style={{
						width: "100%",
						height: "100%",
						objectFit: "contain",
						display: "block",
						transform: `scale(${1.01})`, // tiny overscan prevents edge peeking when rotating
					}}
				/>

				{/* Subtle premium overlay (not a full opaque fill) */}
				<div
					style={{
						position: "absolute",
						inset: 0,
						pointerEvents: "none",
						background:
							"linear-gradient(180deg, rgba(255,255,255,0.06), rgba(255,255,255,0.00) 35%, rgba(0,0,0,0.08) 100%)",
						mixBlendMode: "soft-light",
						opacity: 0.6,
					}}
				/>

				{/* Optional title */}
				{title ? (
					<div
						style={{
							position: "absolute",
							left: 28,
							right: 28,
							bottom: 22,
							color: "rgba(255,255,255,0.92)",
							fontFamily:
								"ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, 'Apple Color Emoji','Segoe UI Emoji'",
							fontSize: 44,
							fontWeight: 700,
							letterSpacing: -0.4,
							textShadow: "0 10px 22px rgba(0,0,0,0.35)",
							lineHeight: 1.05,
						}}
					>
						{title}
					</div>
				) : null}

				{/* Light sweep (clipped to card bounds) */}
				{sweepOpacity > 0.001 ? (
					<div
						style={{
							position: "absolute",
							inset: 0,
							pointerEvents: "none",
							opacity: sweepOpacity,
							mixBlendMode: "screen",
						}}
					>
						<div
							style={{
								position: "absolute",
								left: `${50 + sweepX * 55}%`,
								top: `${50 + sweepY * 45}%`,
								width: "38%",
								height: "180%",
								transform: "translate(-50%, -50%) rotate(22deg)",
								background:
									"linear-gradient(90deg, rgba(255,255,255,0), rgba(255,255,255,0.85), rgba(255,255,255,0))",
								filter: `blur(${10 + 6 * I}px)`,
								opacity: 0.22 + 0.14 * I,
							}}
						/>
					</div>
				) : null}

				{/* Very subtle inner highlight (border-ish, alpha-friendly) */}
				<div
					style={{
						position: "absolute",
						inset: 0,
						borderRadius: radius,
						pointerEvents: "none",
						boxShadow: "inset 0 1px 0 rgba(255,255,255,0.14), inset 0 -1px 0 rgba(0,0,0,0.18)",
						opacity: 0.9,
					}}
				/>
			</div>

			{/* Safety: do not render anything that fills the whole frame with opacity.
          (No background layers here; only FX + card.) */}
		</AbsoluteFill>
	);
};
```

render transparent 

```
npx remotion render src/index.ts ImageHeroTransparentFX out.mov \
  --codec=prores \
  --prores-profile=4444
```

- I came into the issue that the image was not showing, that's because it needs to have staticFile() wrapping the image local path inside the public folder
- Image was cropping, so I had to install
```
npx remotion add @remotion/media-utils
```
### d
	  
	  