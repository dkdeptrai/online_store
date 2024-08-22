import{ReactiveElement as e}from"@lit/reactive-element";export*from"@lit/reactive-element";import{render as t,noChange as n}from"lit-html";export*from"lit-html";
/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */class h extends e{constructor(){super(...arguments),this.renderOptions={host:this},this.o=void 0}createRenderRoot(){const e=super.createRenderRoot();return this.renderOptions.renderBefore??=e.firstChild,e}update(e){const n=this.render();this.hasUpdated||(this.renderOptions.isConnected=this.isConnected),super.update(e),this.o=t(n,this.renderRoot,this.renderOptions)}connectedCallback(){super.connectedCallback(),this.o?.setConnected(!0)}disconnectedCallback(){super.disconnectedCallback(),this.o?.setConnected(!1)}render(){return n}}h._$litElement$=!0,h.finalized=!0,globalThis.litElementHydrateSupport?.({LitElement:h});const r=globalThis.litElementPolyfillSupport;r?.({LitElement:h});const o={_$AK:(e,t,n)=>{e._$AK(t,n)},_$AL:e=>e._$AL};(globalThis.litElementVersions??=[]).push("4.1.0");export{h as LitElement,o as _$LE};

