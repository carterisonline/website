<script>
	import ProjectCard from '/src/components/ProjectCard.svelte';
	import 'uno.css';
	import '/src/reset.css';
</script>

<div class="bg-slate-900 text-slate-400 w-screen h-screen font-sans">
	<div class="p-10">
		<p class="text-white font-bold text-4xl">Projects</p>
		<p class="mt-3">I've got a lot of new projects - Check them out!</p>

		<div class="flex h-100 mt-10">
			<ProjectCard name="Lateral">hi</ProjectCard>
			<ProjectCard name="Dolomite">world</ProjectCard>
		</div>
	</div>
</div>
