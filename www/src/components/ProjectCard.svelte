<script>
	export let name;
	export let projectid;
</script>

<div
	class="card flex-1 bg-slate-800 m-5 overflow-hidden border-slate-600 border-1 rounded-2xl shadow-xl shadow-slate-800"
>
	<img class="w-full max-h-fit overflow-show" src="lateral.png" alt="the" />
	<div class="p-5">
		<p class="text-xl">{name}</p>
		<a href="https://github.com/carterisonline/{projectid}">f</a>
		<slot />
	</div>
</div>
