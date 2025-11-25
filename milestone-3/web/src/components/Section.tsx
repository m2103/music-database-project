export function Section({title, subtitle, children}:{title:string; subtitle?:string; children:React.ReactNode}) {
  return (
    <section style={{marginTop:15}}>
      <div style={{display:"flex", gap:12, alignItems:"baseline"}}>
        <h2 className="text-2xl font-semibold italic" style={{margin:0}}>{title}</h2>
        {subtitle && <small style={{opacity:.75}}>{subtitle}</small>}
      </div>
      <div style={{display:"grid", gridTemplateColumns:"repeat(auto-fit, minmax(180px,1fr))", gap:12, marginTop:12}}>
        {children}
      </div>
    </section>
  );
}