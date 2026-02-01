(async () => {
  const bg = document.getElementById("bg");
  if (!bg) return;

  const STORAGE_KEY = "lastImageIndex";

  let files;
  try {
    const res = await fetch("images.json", { cache: "no-store" });
    if (!res.ok) return;
    const data = await res.json();
    files = Array.isArray(data) ? data.filter((x) => typeof x === "string" && x.length > 0) : [];
  } catch {
    return;
  }

  if (files.length === 0) return;

  const last = Number(localStorage.getItem(STORAGE_KEY) ?? "-1");
  let i = Math.floor(Math.random() * files.length);
  if (files.length > 1 && i === last) i = (i + 1) % files.length;
  localStorage.setItem(STORAGE_KEY, String(i));

  // Preload to avoid a flash of unstyled/previous background.
  const url = `images/${files[i]}`;
  const img = new Image();
  img.decoding = "async";
  img.onload = () => {
    bg.style.backgroundImage = `url("${url}")`;
  };
  img.src = url;
})();

window.addEventListener("load", () => {
  document.getElementById("q")?.blur();
});