//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/PostProcessing/Debug/Overlays" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 38455
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _Params;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
    u_xlat1 = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
    u_xlat2 = u_xlat1 * _ZBufferParams.x;
    u_xlat0 = u_xlat0 * u_xlat2 + _ZBufferParams.y;
    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    SV_Target0.xyz = _Params.xxx * vec3(u_xlat0) + vec3(u_xlat1);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _Params;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
    u_xlat1 = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
    u_xlat2 = u_xlat1 * _ZBufferParams.x;
    u_xlat0 = u_xlat0 * u_xlat2 + _ZBufferParams.y;
    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    SV_Target0.xyz = _Params.xxx * vec3(u_xlat0) + vec3(u_xlat1);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 _Params;
uniform highp sampler2D _CameraDepthTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
float u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = (-unity_OrthoParams.w) + 1.0;
    u_xlat1 = textureLod(_CameraDepthTexture, vs_TEXCOORD1.xy, 0.0).x;
    u_xlat2 = u_xlat1 * _ZBufferParams.x;
    u_xlat0 = u_xlat0 * u_xlat2 + _ZBufferParams.y;
    u_xlat2 = (-unity_OrthoParams.w) * u_xlat2 + 1.0;
    u_xlat0 = u_xlat2 / u_xlat0;
    u_xlat0 = (-u_xlat1) + u_xlat0;
    SV_Target0.xyz = _Params.xxx * vec3(u_xlat0) + vec3(u_xlat1);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 117490
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = 2.0 / u_xlat16_4;
    u_xlat1.xy = u_xlat16_0.xy * vec2(u_xlat16_4);
    u_xlat1.z = u_xlat16_4 + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = 2.0 / u_xlat16_4;
    u_xlat1.xy = u_xlat16_0.xy * vec2(u_xlat16_4);
    u_xlat1.z = u_xlat16_4 + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _CameraDepthNormalsTexture;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xyz = texture(_CameraDepthNormalsTexture, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(3.55539989, 3.55539989, 0.0) + vec3(-1.77769995, -1.77769995, 1.0);
    u_xlat16_4 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_4 = 2.0 / u_xlat16_4;
    u_xlat1.xy = u_xlat16_0.xy * vec2(u_xlat16_4);
    u_xlat1.z = u_xlat16_4 + -1.0;
    u_xlat0.xyz = u_xlat1.xyz * vec3(1.0, 1.0, -1.0);
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOURCE_GBUFFER" }
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOURCE_GBUFFER" }
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOURCE_GBUFFER" }
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToCamera[4];
uniform mediump sampler2D _CameraGBufferTexture2;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
void main()
{
    u_xlat16_0.xyz = texture(_CameraGBufferTexture2, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_WorldToCamera[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_WorldToCamera[0].xyz * u_xlat16_0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToCamera[2].xyz * u_xlat16_0.zzz + u_xlat0.xyw;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOURCE_GBUFFER" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOURCE_GBUFFER" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOURCE_GBUFFER" }
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 161150
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
bool u_xlatb11;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<abs(u_xlat0.x));
#else
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
#endif
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat1.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat1.x * u_xlat6 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = u_xlat15 * u_xlat1.x + u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * _Params.xxyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = u_xlat0.x * 0.318309873 + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * vec3(3.0, 3.0, 3.0) + vec3(-3.0, -2.0, -4.0);
    u_xlat0.xyz = abs(u_xlat0.xyz) * vec3(1.0, -1.0, -1.0) + vec3(-1.0, 2.0, 2.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * vec2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat15 = _MainTex_TexelSize.w * _Params.y;
    u_xlat15 = u_xlat15 / _MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = _Params.y;
    u_xlat1.xy = _MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = (-u_xlat2.xy) * u_xlat1.xy + hlslcc_FragCoord.xy;
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / _MainTex_TexelSize.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xy = texture(_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = inversesqrt(u_xlat11);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11!=0.0);
#else
    u_xlatb11 = u_xlat11!=0.0;
#endif
    u_xlat3.xy = u_xlat16_1.xy * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat16 + -2.0;
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, -0.0625) + u_xlat1.xy;
    u_xlat3.xyz = u_xlat2.xxx * vec3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = (-u_xlat2.xx) * vec2(0.25, 0.125) + u_xlat4.xy;
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / vec2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, 0.0625) + u_xlat1.xy;
    u_xlat3.xw = u_xlat1.xy + vec2(1.0, -0.0);
    u_xlat1.x = u_xlat2.x * -0.25 + u_xlat1.x;
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / vec2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = -abs(u_xlat15) * 0.5 + abs(u_xlat16);
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
bool u_xlatb11;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<abs(u_xlat0.x));
#else
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
#endif
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat1.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat1.x * u_xlat6 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = u_xlat15 * u_xlat1.x + u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * _Params.xxyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = u_xlat0.x * 0.318309873 + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * vec3(3.0, 3.0, 3.0) + vec3(-3.0, -2.0, -4.0);
    u_xlat0.xyz = abs(u_xlat0.xyz) * vec3(1.0, -1.0, -1.0) + vec3(-1.0, 2.0, 2.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * vec2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat15 = _MainTex_TexelSize.w * _Params.y;
    u_xlat15 = u_xlat15 / _MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = _Params.y;
    u_xlat1.xy = _MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = (-u_xlat2.xy) * u_xlat1.xy + hlslcc_FragCoord.xy;
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / _MainTex_TexelSize.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xy = texture(_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = inversesqrt(u_xlat11);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11!=0.0);
#else
    u_xlatb11 = u_xlat11!=0.0;
#endif
    u_xlat3.xy = u_xlat16_1.xy * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat16 + -2.0;
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, -0.0625) + u_xlat1.xy;
    u_xlat3.xyz = u_xlat2.xxx * vec3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = (-u_xlat2.xx) * vec2(0.25, 0.125) + u_xlat4.xy;
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / vec2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, 0.0625) + u_xlat1.xy;
    u_xlat3.xw = u_xlat1.xy + vec2(1.0, -0.0);
    u_xlat1.x = u_xlat2.x * -0.25 + u_xlat1.x;
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / vec2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = -abs(u_xlat15) * 0.5 + abs(u_xlat16);
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	float _RenderViewportScaleFactor;
uniform 	vec4 _MainTex_TexelSize;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _CameraMotionVectorsTexture;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec2 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
vec2 u_xlat7;
float u_xlat10;
bool u_xlatb10;
float u_xlat11;
bool u_xlatb11;
vec2 u_xlat12;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat0.xy = vs_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat0.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    u_xlat0.xy = texture(_CameraMotionVectorsTexture, u_xlat0.xy).xy;
    u_xlat10 = abs(u_xlat0.y);
    u_xlat15 = max(u_xlat10, abs(u_xlat0.x));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(u_xlat10, abs(u_xlat0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<abs(u_xlat0.x));
#else
    u_xlatb10 = u_xlat10<abs(u_xlat0.x);
#endif
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6 = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat1.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat1.x * u_xlat6 + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat15 * u_xlat1.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlat10 = u_xlatb10 ? u_xlat6 : float(0.0);
    u_xlat10 = u_xlat15 * u_xlat1.x + u_xlat10;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb15 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat15 = u_xlatb15 ? -3.14159274 : float(0.0);
    u_xlat10 = u_xlat15 + u_xlat10;
    u_xlat15 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat15<(-u_xlat15));
#else
    u_xlatb15 = u_xlat15<(-u_xlat15);
#endif
    u_xlat1.x = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.xy = u_xlat0.xy * vec2(1.0, -1.0);
    u_xlat2 = u_xlat0.xyxy * _Params.xxyy;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb0 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb15;
    u_xlat0.x = (u_xlatb0) ? (-u_xlat10) : u_xlat10;
    u_xlat0.x = u_xlat0.x * 0.318309873 + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * vec3(3.0, 3.0, 3.0) + vec3(-3.0, -2.0, -4.0);
    u_xlat0.xyz = abs(u_xlat0.xyz) * vec3(1.0, -1.0, -1.0) + vec3(-1.0, 2.0, 2.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xyz);
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = u_xlat2.zw * vec2(0.25, 0.25);
    u_xlat16 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat16 = min(u_xlat16, 1.0);
    u_xlat15 = sqrt(u_xlat15);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat15 = _MainTex_TexelSize.w * _Params.y;
    u_xlat15 = u_xlat15 / _MainTex_TexelSize.z;
    u_xlat1.y = floor(u_xlat15);
    u_xlat1.x = _Params.y;
    u_xlat1.xy = _MainTex_TexelSize.zw / u_xlat1.xy;
    u_xlat2.xy = hlslcc_FragCoord.xy / u_xlat1.xy;
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat12.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = (-u_xlat2.xy) * u_xlat1.xy + hlslcc_FragCoord.xy;
    u_xlat15 = min(u_xlat1.y, u_xlat1.x);
    u_xlat15 = u_xlat15 * 0.707106769;
    u_xlat1.xy = u_xlat12.xy / _MainTex_TexelSize.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat1.xy = u_xlat1.xy * vec2(_RenderViewportScaleFactor);
    u_xlat16_1.xy = texture(_CameraMotionVectorsTexture, u_xlat1.xy).xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(1.0, -1.0);
    u_xlat11 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat12.x = inversesqrt(u_xlat11);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11!=0.0);
#else
    u_xlatb11 = u_xlat11!=0.0;
#endif
    u_xlat3.xy = u_xlat16_1.xy * u_xlat12.xx;
    u_xlat3.z = (-u_xlat3.y);
    u_xlat1.x = dot(u_xlat3.xz, u_xlat2.xy);
    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.xy);
    u_xlat2.x = u_xlat16 * u_xlat15;
    u_xlat15 = u_xlat15 * u_xlat16 + -2.0;
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, -0.0625) + u_xlat1.xy;
    u_xlat3.xyz = u_xlat2.xxx * vec3(0.5, 0.25, -0.125);
    u_xlat4.x = u_xlat3.x;
    u_xlat4.y = 0.0;
    u_xlat3.xw = (-u_xlat2.xx) * vec2(0.25, 0.125) + u_xlat4.xy;
    u_xlat3.xw = (-u_xlat3.xw) + u_xlat4.xy;
    u_xlat16 = dot(u_xlat3.xw, u_xlat3.xw);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat4.xy = u_xlat3.xw / vec2(u_xlat16);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat16 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat7.xy = (-u_xlat2.xx) * vec2(0.375, 0.0625) + u_xlat1.xy;
    u_xlat3.xw = u_xlat1.xy + vec2(1.0, -0.0);
    u_xlat1.x = u_xlat2.x * -0.25 + u_xlat1.x;
    u_xlat6 = dot((-u_xlat3.yz), (-u_xlat3.yz));
    u_xlat6 = sqrt(u_xlat6);
    u_xlat4.xy = (-u_xlat3.yz) / vec2(u_xlat6);
    u_xlat4.z = (-u_xlat4.x);
    u_xlat6 = dot(u_xlat7.xy, u_xlat4.yz);
    u_xlat6 = max(u_xlat16, u_xlat6);
    u_xlat1.x = max((-u_xlat1.x), u_xlat6);
    u_xlat6 = u_xlat15 / abs(u_xlat15);
    u_xlat16 = u_xlat6 * u_xlat3.x;
    u_xlat6 = (-u_xlat6) * u_xlat3.w;
    u_xlat15 = -abs(u_xlat15) * 0.5 + abs(u_xlat16);
    u_xlat15 = max(u_xlat15, abs(u_xlat6));
    u_xlat15 = min(u_xlat15, u_xlat1.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = u_xlatb11 ? u_xlat15 : float(0.0);
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 249230
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.25, 0.25, 0.25);
    SV_Target0 = (u_xlatb1.x) ? vec4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.25, 0.25, 0.25);
    SV_Target0 = (u_xlatb1.x) ? vec4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
ivec4 u_xlati1;
bvec4 u_xlatb1;
bvec4 u_xlatb2;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlatb1 = lessThan(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlatb2 = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0);
    u_xlati1 = ivec4(uvec4((uint(u_xlatb1.x) * 0xffffffffu) | (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb1.y) * 0xffffffffu) | (uint(u_xlatb2.y) * 0xffffffffu), (uint(u_xlatb1.z) * 0xffffffffu) | (uint(u_xlatb2.z) * 0xffffffffu), (uint(u_xlatb1.w) * 0xffffffffu) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb2 = equal(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlati1 = ivec4(uvec4(uint(u_xlati1.x) | (uint(u_xlatb2.x) * 0xffffffffu), uint(u_xlati1.y) | (uint(u_xlatb2.y) * 0xffffffffu), uint(u_xlati1.z) | (uint(u_xlatb2.z) * 0xffffffffu), uint(u_xlati1.w) | (uint(u_xlatb2.w) * 0xffffffffu)));
    u_xlatb1 = equal(u_xlati1, ivec4(0, 0, 0, 0));
    u_xlatb1.x = u_xlatb1.y || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.z || u_xlatb1.x;
    u_xlatb1.x = u_xlatb1.w || u_xlatb1.x;
    u_xlat0.xyz = u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.25, 0.25, 0.25);
    SV_Target0 = (u_xlatb1.x) ? vec4(1.0, 0.0, 1.0, 1.0) : u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 293750
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * -367.857117;
    u_xlat16_9 = u_xlat16_1.x * -367.857117 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(4833.03809, 11677.1963));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * -367.857117;
    u_xlat16_9 = u_xlat16_1.x * -367.857117 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(4833.03809, 11677.1963));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * -367.857117;
    u_xlat16_9 = u_xlat16_1.x * -367.857117 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(4833.03809, 11677.1963));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 343143
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * 66.0126495;
    u_xlat16_9 = u_xlat16_1.x * 66.0126495 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(1855.91467, 14655.8301));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * 66.0126495;
    u_xlat16_9 = u_xlat16_1.x * 66.0126495 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(1855.91467, 14655.8301));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.y * 66.0126495;
    u_xlat16_9 = u_xlat16_1.x * 66.0126495 + (-u_xlat16_9);
    u_xlat16_9 = u_xlat16_1.z * 16511.7441 + u_xlat16_9;
    u_xlat2.z = u_xlat16_9 * 6.0796734e-05;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat16_9 = dot(u_xlat16_1.xy, vec2(1855.91467, 14655.8301));
    u_xlat16_9 = u_xlat16_9 * 6.0796734e-05;
    u_xlat2.xy = min(vec2(u_xlat16_9), vec2(1.0, 1.0));
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 445881
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = vec4(u_xlat16_12) * vec4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323);
    u_xlat16_3.xy = vec2(u_xlat16_12) * vec2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * 0.00778222037;
    u_xlat13 = u_xlat16_2.x / u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat13<0.834949017);
#else
    u_xlatb13 = u_xlat13<0.834949017;
#endif
    u_xlat16_2.xy = vec2(u_xlat16_12) * vec2(-4.58941759e-06, 0.000198408336) + u_xlat16_2.yz;
    u_xlat16_10 = u_xlat16_12 * 0.239932507 + (-u_xlat16_2.w);
    u_xlat2.xy = u_xlat16_2.xy * vec2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = u_xlat13 * 1.61047399 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_12 * -0.0504402146 + u_xlat16_3.x;
    u_xlat16_12 = u_xlat16_12 * -0.00292370259 + (-u_xlat16_3.y);
    u_xlat2.z = u_xlat13 * 14.2738457 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat2.y = (-u_xlat13) * 2.53264189 + u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.y = min(max(u_xlat2.y, 0.0), 1.0);
#else
    u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = vec4(u_xlat16_12) * vec4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323);
    u_xlat16_3.xy = vec2(u_xlat16_12) * vec2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * 0.00778222037;
    u_xlat13 = u_xlat16_2.x / u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat13<0.834949017);
#else
    u_xlatb13 = u_xlat13<0.834949017;
#endif
    u_xlat16_2.xy = vec2(u_xlat16_12) * vec2(-4.58941759e-06, 0.000198408336) + u_xlat16_2.yz;
    u_xlat16_10 = u_xlat16_12 * 0.239932507 + (-u_xlat16_2.w);
    u_xlat2.xy = u_xlat16_2.xy * vec2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = u_xlat13 * 1.61047399 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_12 * -0.0504402146 + u_xlat16_3.x;
    u_xlat16_12 = u_xlat16_12 * -0.00292370259 + (-u_xlat16_3.y);
    u_xlat2.z = u_xlat13 * 14.2738457 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat2.y = (-u_xlat13) * 2.53264189 + u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.y = min(max(u_xlat2.y, 0.0), 1.0);
#else
    u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	float _RenderViewportScaleFactor;
in highp vec3 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec2 u_xlat0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.xy = in_POSITION0.xy + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(_RenderViewportScaleFactor);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 _Params;
uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump float u_xlat16_10;
mediump float u_xlat16_12;
float u_xlat13;
mediump float u_xlat16_13;
bool u_xlatb13;
mediump float u_xlat16_14;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(2.43251014, 11.4688454, 1.76049244));
    u_xlat16_2 = vec4(u_xlat16_12) * vec4(0.00778222037, 5.98477382e-05, -0.000328985829, 0.232164323);
    u_xlat16_3.xy = vec2(u_xlat16_12) * vec2(0.137866527, 0.00933136418);
    u_xlat16_12 = dot(u_xlat16_1.xyz, vec3(6.5019784, 11.0320301, 1.22384095));
    u_xlat16_13 = u_xlat16_12 * 0.00778222037;
    u_xlat13 = u_xlat16_2.x / u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat13<0.834949017);
#else
    u_xlatb13 = u_xlat13<0.834949017;
#endif
    u_xlat16_2.xy = vec2(u_xlat16_12) * vec2(-4.58941759e-06, 0.000198408336) + u_xlat16_2.yz;
    u_xlat16_10 = u_xlat16_12 * 0.239932507 + (-u_xlat16_2.w);
    u_xlat2.xy = u_xlat16_2.xy * vec2(98.8431854, -58.8051376);
    u_xlat13 = (u_xlatb13) ? u_xlat2.x : u_xlat2.y;
    u_xlat2.x = u_xlat13 * 1.61047399 + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat16_14 = u_xlat16_12 * -0.0504402146 + u_xlat16_3.x;
    u_xlat16_12 = u_xlat16_12 * -0.00292370259 + (-u_xlat16_3.y);
    u_xlat2.z = u_xlat13 * 14.2738457 + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.z = min(max(u_xlat2.z, 0.0), 1.0);
#else
    u_xlat2.z = clamp(u_xlat2.z, 0.0, 1.0);
#endif
    u_xlat2.y = (-u_xlat13) * 2.53264189 + u_xlat16_14;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.y = min(max(u_xlat2.y, 0.0), 1.0);
#else
    u_xlat2.y = clamp(u_xlat2.y, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat16_0.xyz) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat0.xyz = _Params.xxx * u_xlat0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = sqrt(u_xlat0.xyz);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}